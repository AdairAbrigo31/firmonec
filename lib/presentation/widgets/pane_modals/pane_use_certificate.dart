
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PaneUseCertificate extends ConsumerWidget{
  
  final void Function() onPressedAccept;

  final void Function(String) onChagedPassword;

  const PaneUseCertificate({super.key , required this.onPressedAccept, required this.onChagedPassword});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    return Container(
      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Column(

        children: [

          const Text( "Por favor ingrese la contraseña del certificado"),

          TextField(

            decoration: const InputDecoration(

              hintText: "Contraseña",

            ),

            onChanged: onChagedPassword,

          ),

          Row(

            children: [

              PrimaryButton(text: "Cancelar", onPressed: (){

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                
              }),
              
              
              PrimaryButton(text: "Aceptar", onPressed: onPressedAccept),

            ],

          )

          

        ],
      )

    );
  }


  
}