
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class CertificateStorage {

  static const String _key = 'saved_certificates';


  static Future<void> saveCertificate(CertificateEntity certificate) async {

    final prefs = await SharedPreferences.getInstance();
    final certificates = await getCertificates();


    if (certificates.any((cert) => cert.id == certificate.id)) {
      throw Exception('Certificate already exists');
    }

    certificates.add(certificate);
    final jsonList = certificates.map((cert) => cert.toMap()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));

  }


  static Future<List<CertificateEntity>> getCertificates() async {

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList
        .map((json) => CertificateEntity.fromMap(json))
        .toList()
      ..sort((a, b) => b.lastUsed?.compareTo(a.lastUsed ?? a.createdAt) ??
          b.createdAt.compareTo(a.createdAt));
  }



  static Future<void> updateCertificate(CertificateEntity updatedCertificate) async {

    final prefs = await SharedPreferences.getInstance();
    final certificates = await getCertificates();

    final index = certificates.indexWhere((cert) => cert.id == updatedCertificate.id);
    if (index == -1) throw Exception('Certificate not found');

    certificates[index] = updatedCertificate;
    final jsonList = certificates.map((cert) => cert.toMap()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));

  }



  static Future<void> deleteCertificate(String certificateId) async {

    final prefs = await SharedPreferences.getInstance();
    final certificates = await getCertificates();

    certificates.removeWhere((cert) => cert.id == certificateId);
    final jsonList = certificates.map((cert) => cert.toMap()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));

  }



  static Future<void> updateLastUsed(String certificateId) async {

    final certificates = await getCertificates();
    final certificate = certificates.firstWhere(
          (cert) => cert.id == certificateId,
      orElse: () => throw Exception('Certificate not found'),
    );

    final updatedCertificate = CertificateEntity(
      id: certificate.id,
      name: certificate.name,
      filePath: certificate.filePath,
      password: certificate.password,
      createdAt: certificate.createdAt,
      lastUsed: DateTime.now(),
      alias: certificate.alias,
    );

    await updateCertificate(updatedCertificate);
  }

}