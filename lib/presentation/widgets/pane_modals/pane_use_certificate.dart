
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
      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Column(

        children: [

           Text("El certificado seleccionado es: ${certificateEntity.alias}"),

          const Text( "Por favor ingrese la contraseña del certificado"),

          TextField(

            decoration: const InputDecoration(

              hintText: "Contraseña",

            ),

            onChanged: onChangedPassword,

          ),

          Row(

            children: [

              PrimaryButton(text: "Cancelar", onPressed: (){

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                
              }),
              
              
              PrimaryButton(
                
                text: "Aceptar", 
                
                onPressed: onPressedAccept
                
              ),

            ],

          )

          

        ],
      )

    );
  }


  
}