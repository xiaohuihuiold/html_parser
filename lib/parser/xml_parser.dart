import 'package:html_parser/exception/html_empty_exception.dart';
import 'package:html_parser/exception/element_tag_null_exception.dart';
import 'package:html_parser/html/document.dart';
import 'package:html_parser/html/element.dart';

class XmlParser {
  String _html;

  get html => _html;
  Document _document;

  get document => _document;

  XmlParser.html(String html) {
    _html = html;
    _parse();
  }

  void _parse() {
    if (_html == null || _html.length == 0) {
      throw HtmlEmptyException('html内容为空');
    }
    _document = Document();
    Element root = Element();
    root.tag = 'root';
    _document.root = root;
    _parseElement(root, 0);
  }

  /// 解析出element结构
  /// [parent] 父element
  /// [index] html下标
  /// 返回[下标,状态]
  List<int> _parseElement(Element parent, int index) {
    int i = index;
    Element element;
    for (; i < _html.length; i++) {
      String char = _html[i];
      String charNext = () {
        if (i + 1 < _html.length) {
          return _html[i + 1];
        }
        return null;
      }();
      if (char == '<') {
        if (charNext != '/') {
          // 标签开始
          if (element == null) {
            element = Element();
            i = _parseElementTag(element, ++i);
            if (_html[i] == ' ') {
              i = _parseAttributes(element, ++i);
              _parseElementID(element);
              _parseElementClass(element);
            }
            parent.addElement(element);
          } else {
            // 发现新的element
            List<int> result = _parseElement(element, --i);
            i = result[0];
            if (result[1] > 0) {
              result[1] = result[1] - 1;
              return result;
            }
            continue;
          }
        } else if (charNext == '/') {
          // 标签结束
          Element test = Element();
          i++;
          // 因为是charNext,所以需要多加一次
          i++;
          i = _parseElementCloseTag(test, i);
          // 计算需要跳过的次数
          int num = 0;
          Element temp = element;
          while (test.tag != temp.tag) {
            temp = temp.parent;
            num++;
            if (temp == null) {
              break;
            }
          }
          return [i, num];
        }
      } else if (char == '/') {
        if (charNext == '>') {
          return [++i, 0];
        }
      }
    }
    return [i, 0];
  }

  /// 解析出tag名
  /// 返回新的index
  int _parseElementTag(Element element, int index) {
    int i = index;
    String tag = '';
    for (; i < _html.length; i++) {
      String char = _html[i];
      if (char == ' ' || char == '/' || char == '>') {
        element.tag = tag;
        if (char == '/') {
          return i - 1;
        }
        return i;
      }
      tag += char;
    }
    element.tag = tag;
    return i;
  }

  /// 解析出结束tag名
  /// 返回新的index
  int _parseElementCloseTag(Element element, int index) {
    int i = index;
    String tag = '';
    for (; i < _html.length; i++) {
      String char = _html[i];
      if (char == '>') {
        element.tag = tag;
        return i;
      }
      tag += char;
    }
    element.tag = tag;
    return i;
  }

  /// 解析属性
  /// 返回新的index
  int _parseAttributes(Element element, int index) {
    int i = index;
    String attr = '';
    for (; i < _html.length; i++) {
      String char = _html[i];
      String charNext = () {
        if (i + 1 < _html.length) {
          return _html[i + 1];
        }
        return null;
      }();
      if (char == '>' || (char == '/' && charNext == '>')) {
        _parseAttributesKV(element, attr);
        return i - 1;
      }
      attr += char;
    }
    return i;
  }

  /// 解析属性详细
  void _parseAttributesKV(Element element, String attr) {
    if (attr == null || attr.length == 0) return;
    String mark = '';
    String name = '';
    String value = '';
    for (int i = 0; i < attr.length; i++) {
      String char = attr[i];
      if (mark.isEmpty && char == ' ') {
        continue;
      }
      if (name.isEmpty) {
        for (; i < attr.length; i++) {
          String char = attr[i];
          if (char != '=') {
            if (char == ' ') {
              element.putAttribute(name, true);
              name = '';
              break;
            }
            name += char;
          } else {
            break;
          }
        }
      } else {
        for (; i < attr.length; i++) {
          String char = attr[i];
          if (char == '"' || char == "'") {
            if (mark.isEmpty) {
              mark = char;
            } else {
              mark = '';
              element.putAttribute(name, value);
              name = '';
              value = '';
              break;
            }
          } else {
            if (mark.isNotEmpty) {
              value += char;
            }
          }
        }
      }
    }
  }

  /// 解析id
  void _parseElementID(Element element) {
    element.id = element.getAttribute('id');
  }

  /// 解析class
  void _parseElementClass(Element element) {
    List<String> classes =
        (element.getAttribute('class') as String)?.split('\s+');
    classes?.forEach((clazz) {
      element.addClass(clazz);
    });
  }
}
