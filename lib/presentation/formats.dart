class Formats {
  static String formatDate(String date) {
    final fecha = DateTime.parse(date);

    return "${fecha.day}/${fecha.month}/${fecha.year}";
  }
}
