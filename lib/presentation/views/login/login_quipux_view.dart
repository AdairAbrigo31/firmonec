
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/infrastructure/repositories/repositories.dart';
import 'package:tesis_firmonec/presentation/controllers/get_information_user_controller.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class LoginQuipuxView extends ConsumerWidget{
  const LoginQuipuxView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stateLogin = ref.watch(loginQuipuxFormProvider);
    final notifierLogin = ref.read(loginQuipuxFormProvider.notifier);

    return SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  const Text("Login de Quipux"),
                  Row(
                    children: [
                     const Expanded(child: Text("Tipo de Quipux")),
                     Expanded(
                         child: DropdownButton(
                           value: stateLogin.type,
                             items: [
                               DropdownMenuItem(value: TypesQuipux.quipuxNatural(),child: const Text("Natural"),),
                               DropdownMenuItem(value: TypesQuipux.quipuxEspol()  ,child: const Text("ESPOL"),),
                             ], onChanged: (value){
                               notifierLogin.updateType(value!);
                         }
                         )
                     )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {

                        final valid = await RepositoryFirmonecImplementation().loginWithMicrosoft();
                        if(valid.success && context.mounted) {
                          GetInformationUserController.execute(valid.token!, ref);
                          context.goNamed('roles_documents_quipux');
                        }
                      },

                      child: const Text("Iniciar sesión")
                  )
                ],
              ),
              if(stateLogin.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

            ],
          ),

        )
    );
  }


}