import 'package:html_parser/exception/html_empty_exception.dart';

class XmlParser {
  StringBuffer stringBuffer = StringBuffer();

  XmlParser.html(String html) {
    stringBuffer.write(html);
    _parse();
  }

  void _parse() {
    if (stringBuffer == null || stringBuffer.length == 0)
      throw HtmlEmptyException('html内容为空');
  }
}
