import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/certificate_storage.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/login/user_active_provider.dart';
import 'package:tesis_firmonec/presentation/providers/signed/documents_selected_provider.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

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
        await showDialog<String>(

          context: context,

          builder: (context) {

            final nameCertificate = result.files.single.name;
            String description = '';

            return ModalLayouts(context).showSimpleModal(

              child: PaneSaveCertificates(

                nameCertificate: nameCertificate,
                onChangedDescription: (value) {
                  description = value;
                },

                onPressedAccept: () {

                  final CertificateEntity certificate = CertificateEntity(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameCertificate,
                      alias: description,
                      password: "contrasena",
                      emailOwner: emaiUser,
                      createdAt: DateTime.now(),
                      lastUsed: null,
                      filePath: result.files.single.path!,
                    ); 

                    CertificatesUserController.saveCertificateUser(certificate);

                    context.pop();

                },
              ),
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

                                ref.read(documentSelectedProvider.notifier).updateCertificate(cert);

                                showDialog(
                                  
                                  context: context, 
                                  
                                  builder: (context) => ModalLayouts(context).showSimpleModal(

                                    child: PaneUseCertificate(

                                      descriptionCertificate: cert.alias,

                                      onPressedAccept: (){

                                        SignDocumentsController.handleSignDocuments(context, ref, cert);

                                        if(context.mounted){

                                          Navigator.of(context).pop();
                                        
                                        }

                                      }, 
                                      
                                      onChagedPassword: (value) {

                                        ref.read(documentSelectedProvider.notifier).updatePassword(value);


                                      }
                                    )
                                  )
                                );
                    

                                await CertificateStorage.updateLastUsed(cert.id, user.email ?? 'prueba');



                              } else if (value == 'delete') {

                                await CertificateStorage.deleteCertificate(

                                  cert.id, user.email ?? 'prueba'
                              
                                );

                                setState(() {});

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

              },
            ),
          ],
        ),
      ),
    );
  }
}
