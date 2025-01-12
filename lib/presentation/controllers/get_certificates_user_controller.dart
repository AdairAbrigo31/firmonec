
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';

class GetCertificatesUserController {

  static Future<List<CertificateEntity>> getCertificatesUser(String userEmail) async {

    try {
      final certificates = await CertificateStorage.getCertificates(userEmail);
      return certificates;
    } catch (e) {
      throw e;
    }
  }

}