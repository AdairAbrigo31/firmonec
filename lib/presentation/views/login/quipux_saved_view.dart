
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tesis_firmonec/presentation/providers/persistence/credentials_quipux_provider.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';


class QuipuxSaveView extends ConsumerWidget {
  const QuipuxSaveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateCredentials = ref.watch(credentialsQuipuxProvider);

    return SafeArea(

      child: Center(

        child: Padding(

          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [

              if (stateCredentials.credentials.isEmpty)

                const Center(
                  child: Text(
                    "No hay cuentas Quipux guardadas",
                    style: TextStyle(fontSize: 16),
                  ),
                )


              else

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      
                      const Text(
                        "Quipux guardados",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final credential = stateCredentials.credentials[index];
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("Cuenta $index")
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              PrimaryButton(
                  text: 'Agregar certificado',
                  onPressed: (){}
              )
            ],
          ),
        ),
      ),
    );
  }
}
