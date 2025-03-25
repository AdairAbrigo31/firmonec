import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class DocumentsSignedView extends ConsumerStatefulWidget {
  const DocumentsSignedView({super.key});
  @override
  ConsumerState<DocumentsSignedView> createState() =>
      _DocumentsSignedViewState();
}

class _DocumentsSignedViewState extends ConsumerState<DocumentsSignedView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowSavePasswordDialog();
    });
  }

  void _checkAndShowSavePasswordDialog() async {
    final resultsDocumentsSigned = ref.read(resultsDocumentsSignedProvider);

    final stateDocumentsSelected = ref.read(documentSelectedProvider);

    final isSavedCertificate = await CertificateStorage.isSavedCertificate(
        stateDocumentsSelected.certificate!);

    if (resultsDocumentsSigned.success >= 1 &&
        stateDocumentsSelected.certificate!.password != null &&
        isSavedCertificate) {
      final stateUser = ref.read(userActiveProvider);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Guardar contraseña'),
          content: const Text('¿Desea guardar la contraseña del certificado?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                final updatedCertificate = stateDocumentsSelected.certificate!
                    .copyWith(password: stateDocumentsSelected.password);

                await CertificateStorage.updateCertificate(updatedCertificate);

                await CertificateStorage.updateLastUsed(
                    updatedCertificate.id, stateUser.email!);

                if (context.mounted) {
                  context.pop();
                }
              },
              child: const Text('Sí'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultsDocumentsSigned = ref.read(resultsDocumentsSignedProvider);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
                " Se han intentado firmar: ${resultsDocumentsSigned.error + resultsDocumentsSigned.success}"),
            Text(
                "Total de documentos firmados con exito: ${resultsDocumentsSigned.success}"),
            Text(
                "Total de documentos con error: ${resultsDocumentsSigned.error}"),
            if (resultsDocumentsSigned.error >= 1)
              const Text("Por favor revise en Quipux su carpeta de No enviados")
          ]),
          const SizedBox(height: 16),
          Expanded(
              child: ListView.builder(
                  itemCount: resultsDocumentsSigned.documentsSigned.length,
                  itemBuilder: (context, index) {
                    return Text(resultsDocumentsSigned
                        .documentsSigned[index].documentId);
                  })),
          PrimaryButton(
              text: "Continuar",
              onPressed: () async {
                try {
                  LoadingModal.show(context);

                  await GetInformationUserController
                      .refreshDataQuipuxWithoutToken(ref, context);
                } catch (error) {
                  throw ("$error");
                } finally {
                  LoadingModal.hide(context);
                }

                router.goNamed("roles_documents_quipux");
              })
        ]));
  }
}
