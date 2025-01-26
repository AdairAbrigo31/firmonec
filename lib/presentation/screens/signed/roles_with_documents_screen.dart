
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/views/signed/roles_with_documents_view.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class RolesWithDocumentsScreen extends ConsumerWidget {

  const RolesWithDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(

      appBar: AppBarFirmonec(
        
        title: "Roles y documentos 2", 
        
        showBackButton: false, 

        automaticallyImplyLeading: false,
        
        actions: [

          IconButton(
            
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
              },
          
            icon: Icon(Icons.refresh_outlined, color: Theme.of(context).colorScheme.surface,)
            
          )

        ],
        
      ),

      body: const RolesWithDocumentsView(),

    );
  }


}