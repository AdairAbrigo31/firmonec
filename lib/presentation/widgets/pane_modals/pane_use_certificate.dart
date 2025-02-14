
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class PaneUseCertificate extends ConsumerWidget{
  
  final void Function() onPressedAccept;
  final CertificateEntity certificateEntity;


  const PaneUseCertificate({
    super.key , 
    required this.onPressedAccept, 
    required this.certificateEntity
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final notifierFormToSign = ref.read(documentSelectedProvider.notifier);
    
    return Container(

      width: double.infinity,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),

        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            Text(
              "El certificado seleccionado es: ${certificateEntity.alias}",
              style: AppTypography.bodyMedium,
            ),

            const SizedBox(height: 12),

            const Text( "Por favor ingrese la contraseña del certificado"),

            const SizedBox(height: 10),

            TextField(

              decoration: InputDecoration(

                hintText: "Contraseña",
                hintStyle: AppTypography.bodyMedium,
                border: const OutlineInputBorder(),

              ),

              onChanged: (value) {

                notifierFormToSign.updatePassword(value);

              },

            ),

            const SizedBox(height: 16),

            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye botones
              children: [
                const Expanded(

                  child: Padding(

                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: CancelButton(

                      text: "Cancelar",

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
      )

    );
  }


  
}