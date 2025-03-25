import 'package:flutter/material.dart';

class RolesWithDocumentsAuxiliars {
  static Color getColorCategoryDocument(String category) {
    if (category == "Normal") {
      return Colors.blue;
    } else if (category == "Personal") {
      return Colors.green;
    } else if (category == "Urgente") {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
}
