import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/certificate_storage.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/login/user_active_provider.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class CertificatesForSignView extends ConsumerStatefulWidget {
  const CertificatesForSignView({super.key});

  @override
  ConsumerState<CertificatesForSignView> createState() =>
      CertificatesForSignViewState();
}

class CertificatesForSignViewState extends ConsumerState<CertificatesForSignView> {
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _pickFile(String emaiUser) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['p12'],
        allowMultiple: false,
      );

      if (result != null) {
        
        //Modal para introducir descripcion y contraseña para validar el guardado
        final description = await showDialog<String>(
          context: context,
          builder: (context) {
            final nameCertificate = result.files.single.name;
            final controller = TextEditingController();
            final passwordController = TextEditingController();

            return AlertDialog(
              title: const Text('Agregar certificado'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nombre del certificado: $nameCertificate',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    final CertificateEntity certificateEntity = CertificateEntity(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameCertificate,
                      alias: controller.text,
                      password: passwordController.text,
                      emailOwner: emaiUser,
                      createdAt: DateTime.now(),
                      lastUsed: null,
                      filePath: result.files.single.path!,
                    ); 
                    CertificateStorage.saveCertificate(certificateEntity);
                    Navigator.pop(context, controller.text);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al seleccionar el archivo: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = ref.watch(userActiveProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Certificados guardados",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Seleccione un certificado para firmar o agregue uno nuevo",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: FutureBuilder(
                future: CertificateStorage.getCertificates(user.email ?? 'prueba'),
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
                      final cert = certificates[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.verified_user,
                              color: Colors.blue,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cert.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cert.alias),
                            ],
                          ),


                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'use',
                                child: Text('Usar certificado'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Eliminar'),
                              ),
                            ],
                            onSelected: (value) async {

                              if (value == 'use') {

                                SignDocumentsController.handleSignDocuments(context, ref, cert);

                                await CertificateStorage.updateLastUsed(cert.id, user.email ?? 'prueba');



                              } else if (value == 'delete') {


                                // Confirmar eliminación
                                final confirm = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Eliminar certificado'),
                                    content: const Text(
                                        '¿Está seguro que desea eliminar este certificado?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await CertificateStorage.deleteCertificate(
                                      cert.id, user.email ?? 'prueba');
                                  setState(() {}); // Recargar lista
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: "Agregar certificado",
              onPressed: () {

                _pickFile(user.email ?? 'prueba');
                // Implementar lógica para agregar certificado
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
