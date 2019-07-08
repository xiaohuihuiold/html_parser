class HtmlEmptyException implements Exception {
  final String message;

  HtmlEmptyException(this.message);

  @override
  String toString() => 'HtmlEmptyException:$message';
}
