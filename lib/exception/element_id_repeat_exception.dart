import 'element_exception.dart';

class ElementIDRepeatException extends ElementException {
  ElementIDRepeatException(String message) {
    this.type = ElementExceptionType.ID_REPEAT;
    this.message = message;
  }

  @override
  String toString() => 'ElementIDRepeatException: $message';
}
