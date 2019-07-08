import 'element_id_repeat_exception.dart';
import 'element_root_null_exception.dart';
import 'element_tag_null_exception.dart';

enum ElementExceptionType {
  ID_REPEAT,
  TAG_EMPTY,
  ROOT_EMPTY,
}

abstract class ElementException implements Exception {
  ElementExceptionType type;
  String message;

  ElementException();

  factory ElementException.generate(ElementExceptionType type, String message) {
    switch (type) {
      case ElementExceptionType.ID_REPEAT:
        return ElementIDRepeatException(message);
      case ElementExceptionType.TAG_EMPTY:
        return ElementTagNullException(message);
      case ElementExceptionType.ROOT_EMPTY:
        return ElementRootNullException(message);
      default:
        return null;
    }
  }
}
