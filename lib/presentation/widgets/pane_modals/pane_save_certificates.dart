import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class PaneSaveCertificates extends ConsumerWidget {
  final void Function() onPressedAccept;
  final void Function(String) onChangedDescription;
  final String nameCertificate;

  const PaneSaveCertificates({
    super.key,
    required this.onPressedAccept,
    required this.onChangedDescription,
    required this.nameCertificate
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
              "El certificado seleccionado es: $nameCertificate",
              textAlign: TextAlign.center,
              
            ),

            const SizedBox(height: 12),

            Text(
              "Ingrese una pequeña descripción para el certificado",
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium,
            ),

            const SizedBox(height: 10),

            TextField(

              decoration: InputDecoration(

                hintText: "Certificado FirmaEC",
                hintStyle: AppTypography.bodyMedium,
                border: const OutlineInputBorder(),

              ),
              onChanged: onChangedDescription,
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
        ),
      )
    );
  }
}