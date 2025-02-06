extension StringExtensions on String {
  String capitalize() {
    var words = this.split(" ");
    return words
        .map((word) => "${word[0].toUpperCase()}${word.substring(1)}")
        .join(" ");
  }
}
