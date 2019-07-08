import 'element_exception.dart';

class ElementTagNullException extends ElementException {
  ElementTagNullException(String message) {
    this.type = ElementExceptionType.TAG_EMPTY;
    this.message = message;
  }

  @override
  String toString() => 'ElementTagNullException: $message';
}
