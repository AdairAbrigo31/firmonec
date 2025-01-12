
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PaneSaveCertificates extends ConsumerWidget{
  
  final void Function() onPressedAccept;

  final void Function(String) onChangedDescription;

  const PaneSaveCertificates({super.key , required this.onPressedAccept, required this.onChangedDescription});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    return Container(
      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Column(

        children: [

          const Text( "Ingrese una pequeña descripción para el certificado"),

          TextField(

            decoration: const InputDecoration(

              hintText: "Certificado FirmaEC",

            ),

            onChanged: onChangedDescription,

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