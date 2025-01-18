import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PaneSaveCertificates extends ConsumerWidget {
  final void Function() onPressedAccept;
  final void Function(String) onChangedDescription;
  final void Function(String) onChangedPassword;
  final String nameCertificate;

  const PaneSaveCertificates({
    super.key,
    required this.onPressedAccept,
    required this.onChangedDescription,
    required this.onChangedPassword,
    required this.nameCertificate
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(

      width: double.infinity, // Asegura ancho completo
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      
      child: Column(

        mainAxisSize: MainAxisSize.min, // Importante
        crossAxisAlignment: CrossAxisAlignment.stretch, // Alinea contenido
        children: [

          Text(
            "El certificado seleccionado es: $nameCertificate",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          const Text(
            "Ingrese una pequeña descripción para el certificado",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          TextField(

            decoration: const
             InputDecoration(

              hintText: "Certificado FirmaEC",
              border: OutlineInputBorder(),

            ),
            onChanged: onChangedDescription,
          ),

          const SizedBox(height: 16),

          const Text(
            "Ingrese la contraseña del cetificado",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          TextField(

            decoration: const
             InputDecoration(

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

                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),

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
    );
  }
}