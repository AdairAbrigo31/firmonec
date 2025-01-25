
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';


class DocumentsSignedView extends ConsumerStatefulWidget {

  const DocumentsSignedView({super.key});
  @override
  ConsumerState<DocumentsSignedView> createState() => _DocumentsSignedViewState();

}

class _DocumentsSignedViewState extends ConsumerState<DocumentsSignedView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowSavePasswordDialog();
    });
  }


  void _checkAndShowSavePasswordDialog() {

    final resultsDocumentsSigned = ref.read(resultsDocumentsSignedProvider);

    final stateDocumentsSelected = ref.read(documentSelectedProvider);

    if (resultsDocumentsSigned['success'] > 1 && stateDocumentsSelected.certificate!.password != null) {

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
                final updatedCertificate = stateDocumentsSelected.certificate!.copyWith(
                  password: stateDocumentsSelected.password
                );

                await CertificateStorage.updateCertificate(updatedCertificate);

                await CertificateStorage.updateLastUsed(updatedCertificate.id, stateUser.email!);

                Navigator.pop(context);
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

    return Center(
      
      child: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [

                const Text("Total de documentos firmados: "),

                Text("${resultsDocumentsSigned['total']}")
              ],
            ),


            Row(
              children: [

                const Text("Total de documentos firmados cone exito: "),

                Text("${resultsDocumentsSigned['success']}")
              ],
            ),

            Row(
              children: [

                const Text("Total de documentos con error: "),

                Text("${resultsDocumentsSigned['errors']}")
              ],
            ),



            PrimaryButton(
              
              text: "Continuar", 
              
              onPressed: () async {

                try {

                  LoadingModal.show(context);

                  await GetInformationUserController.refreshDataQuipuxWithoutToken(ref, context);


                } catch (error) {

                  throw ("$error");


                }  finally {

                  LoadingModal.hide(context);

                }

                router.goNamed( "roles_documents_quipux" );
              }
            
            )
                    
          ]
        ),
      ) 
    );
  }
  


}
