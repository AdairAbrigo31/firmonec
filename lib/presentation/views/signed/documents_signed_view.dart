
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/signed/results_documents_signed_provider.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class DocumentsSignedView extends ConsumerWidget {

  const DocumentsSignedView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final resultsDocumentsSigned = ref.read(resultsDocumentsSignedProvider);
    

    return SafeArea(
      
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

                //Modal Loading

                await GetInformationUserController.refreshDataQuipux(ref);

                //Cerrar Modal Loading


                router.goNamed( "roles_documents_quipux" );
              }
            
            )
                    
          ]
        ),
      ) 
    );
  }
  


}
