import 'element_exception.dart';

class ElementRootNullException extends ElementException {
  ElementRootNullException(String message) {
    this.type = ElementExceptionType.TAG_EMPTY;
    this.message = message;
  }

  @override
  String toString() => 'ElementRootNullException: $message';
}
