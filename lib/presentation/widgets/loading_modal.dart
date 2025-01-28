import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key});

  // Método estático para mostrar el modal
  static Future<void> show(BuildContext context) async {
    if (!context.mounted) return;
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false, // Previene el cierre con el botón atrás
        child: const LoadingModal(),
      ),
    );
  }

  // Método estático para ocultar el modal
  static Future<void> hide(BuildContext context) async {
    if (!context.mounted) return;
    
    // Verificamos si el diálogo está visible antes de intentar cerrarlo
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 8, // Añadimos elevación para mejor apariencia
      shape: RoundedRectangleBorder( // Bordes redondeados
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}