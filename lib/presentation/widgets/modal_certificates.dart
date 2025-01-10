import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tesis_firmonec/presentation/providers/certificates/certificates.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';


class ModalCertificates extends ConsumerStatefulWidget {
  const ModalCertificates({super.key});

  @override
  ConsumerState<ModalCertificates> createState() => ModalCertificatesState();
}

class ModalCertificatesState extends ConsumerState<ModalCertificates> {
  bool _showPassword = false;


  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['p12'],
        allowMultiple: false,
      );

      if (result != null) {
        ref.read(certificateSelectedFileProvider.notifier).state = result.files.first;
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al seleccionar el archivo: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final selectedFile = ref.watch(certificateSelectedFileProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccionar Certificado Digital',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Selector de archivo
            InkWell(
              onTap: _isLoading ? null : _pickFile,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: Colors.blue[700],
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedFile?.name ?? 'Seleccionar certificado P12',
                            style: TextStyle(
                              color: selectedFile != null ? Colors.black : Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (selectedFile != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${(selectedFile.size / 1024).toStringAsFixed(2)} KB',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    if (_isLoading)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                  ],
                ),
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],

            const SizedBox(height: 16),

            TextField(
              onChanged: (value) {

              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancelar',
                ),
                const SizedBox(width: 8),
                PrimaryButton(
                  onPressed: selectedFile != null ?
                      () {

                    // Firmar

                      }

                      :

                      (){},

                  text: 'Firmar',
                  ),
              ],
            ),
          ],
        ),
      )

    );
  }
}