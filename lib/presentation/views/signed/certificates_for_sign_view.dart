import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/radio_button_certificate.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class CertificatesForSignView extends ConsumerStatefulWidget {
  const CertificatesForSignView({super.key});

  @override
  ConsumerState<CertificatesForSignView> createState() =>
      CertificatesForSignViewState();
}

class CertificatesForSignViewState
    extends ConsumerState<CertificatesForSignView> {
  String? _errorMessage;
  bool _isLoading = false;
  late Future<List<CertificateEntity>> _certificatesFuture;

  Future<void> _pickFile(String emailUser) async {
    try {
      setState(() => _isLoading = true);

      final result = await CertificatesUserController.pickCertificateFile();
      if (result == null) return;

      final file = File(result.files.single.path!);
      final base64String =
          await CertificatesUserController.getBase64FromFile(file);

      await _showSaveCertificateDialog(
        fileName: result.files.single.name,
        filePath: result.files.single.path!,
        base64String: base64String,
        emailUser: emailUser,
      );
    } catch (e) {
      setState(() => _errorMessage = 'Error al seleccionar el archivo: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _showSaveCertificateDialog({
    required String fileName,
    required String filePath,
    required String base64String,
    required String emailUser,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          String description = "";

          return ModalLayouts(context).showSimpleModal(
            child: PaneSaveCertificates(
              nameCertificate: fileName,
              onChangedDescription: (value) {
                description = value;
              },
              onPressedAccept: () async {
                final certificate = CertificateEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: fileName,
                  alias: description,
                  emailOwner: emailUser,
                  filePath: filePath,
                  base64: base64String,
                  createdAt: DateTime.now(),
                );

                await CertificatesUserController.saveCertificateUser(
                    certificate);

                setState(() {
                  _certificatesFuture =
                      CertificateStorage.getCertificates(emailUser);
                });

                if (context.mounted) {
                  context.pop();
                }
              },
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userActiveProvider);
    _certificatesFuture = CertificateStorage.getCertificates(
        user.email!); // Inicializamos el future
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userActiveProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seleccione un certificado",
                  style: AppTypography.bodyMedium,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Añadir",
                        style: AppTypography.bodyMedium,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.add_circle_outline_rounded)
                    ],
                  ),
                  onTap: () async {
                    await _pickFile(user.email!);
                  },
                )
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder(
                future: _certificatesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  final certificates = snapshot.data ?? [];

                  if (certificates.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No hay certificados guardados',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: certificates.length,
                    itemBuilder: (context, index) {
                      final certificate = certificates[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            RadioButtonCertificate(certificate),

                            // El resto del contenido fuera del Consumer
                            Expanded(
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.verified_user,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        certificate.name,
                                        style: AppTypography.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      certificate.alias,
                                      style: AppTypography.bodySmall,
                                    ),
                                  ],
                                ),
                                trailing: PopupMenuButton(
                                  icon: const Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Eliminar'),
                                    ),
                                  ],
                                  onSelected: (value) async {
                                    if (value == 'delete') {
                                      await CertificateStorage
                                          .deleteCertificate(
                                              certificate.id, user.email!);
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                text:
                    "Firmar ( ${ref.watch(documentSelectedProvider).totalDocuments} )",
                onPressed: () async {
                  try {
                    final documentsSelectedState =
                        ref.read(documentSelectedProvider);

                    if (documentsSelectedState.certificate == null) {
                      var snackBar = const SnackBar(
                          content: Text('Debes seleccionar un certificado'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    final stateForSign = ref.read(documentSelectedProvider);

                    if (stateForSign.certificate!.password != null) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return ModalLayouts(context).showSimpleModal(
                                child: PaneUseCertificate(
                                    onPressedAccept: () async {
                                      try {
                                        await SignDocumentsOneByOneController
                                            .signDocumentsOneByOneWithoutPasswordSaved(
                                                context, ref);

                                        await CertificateStorage.updateLastUsed(
                                            ref
                                                .read(documentSelectedProvider)
                                                .certificate!
                                                .id,
                                            user.email!);

                                        router.goNamed('documents_signed');
                                      } catch (error) {
                                        print("Error: $error");
                                      }
                                    },
                                    certificateEntity:
                                        stateForSign.certificate!));
                          });
                    } else {
                      try {
                        await SignDocumentsOneByOneController
                            .signDocumentsOneByOneWithPasswordSaved(
                                context, ref);

                        await CertificateStorage.updateLastUsed(
                            ref.read(documentSelectedProvider).certificate!.id,
                            user.email!);

                        router.goNamed('documents_signed');
                      } catch (error) {
                        print("Error: $error");
                      }
                    }
                  } catch (e) {
                    throw ("$e");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
