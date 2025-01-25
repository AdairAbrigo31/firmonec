
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';

class CertificatesUserController {

  static Future<List<CertificateEntity>> getCertificatesUser(String userEmail) async {

    try {

      final certificates = await CertificateStorage.getCertificates(userEmail);
      return certificates;

    } catch (e) {

      throw e;

    }
  }



  static Future<void> saveCertificateUser(CertificateEntity certificate) async {
    
    try {

      await CertificateStorage.saveCertificate(certificate);

    } catch (e) {

      throw e;

    }
  }



  static Future<FilePickerResult?> pickCertificateFile() {

    return FilePicker.platform.pickFiles(

      type: FileType.custom,
      allowedExtensions: ['p12'],
      allowMultiple: false,

    );
  }


  static Future<String> getBase64FromFile(File file) async {

    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
    
  }



}