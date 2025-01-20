
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PaneUseCertificate extends ConsumerWidget{
  
  final void Function() onPressedAccept;

  final void Function(String) onChangedPassword;

  final CertificateEntity certificateEntity;

  const PaneUseCertificate({
    super.key , 
    required this.onPressedAccept, 
    required this.onChangedPassword, 
    required this.certificateEntity
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Column(

        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [

           Text("El certificado seleccionado es: ${certificateEntity.alias}"),

           const SizedBox(height: 16),

          const Text( "Por favor ingrese la contraseña del certificado"),

          TextField(

            decoration: const InputDecoration(

              hintText: "Contraseña",
              border: OutlineInputBorder(),

            ),

            onChanged: onChangedPassword,

          ),

          const SizedBox(height: 16),

          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye botones
            children: [
              Expanded(

                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: PrimaryButton(

                    text: "Cancelar",

                    onPressed: () {

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }

                  ),
                ),
              ),

              Expanded(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),

                  child: PrimaryButton(

                    text: "Aceptar",

                    onPressed: onPressedAccept

                  ),
                ),
              ),
            ],
          ),

          

        ],
      )

    );
  }


  
}