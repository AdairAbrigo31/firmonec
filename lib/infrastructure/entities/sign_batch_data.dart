
class SignBatchData {

  final int codeUser;
  final List<String> documentIds;
  final String base64Certificate;
  final String keyCertificate;

  SignBatchData({
    required this.codeUser,
    required this.documentIds,
    required this.base64Certificate,
    required this.keyCertificate,
  });

}
