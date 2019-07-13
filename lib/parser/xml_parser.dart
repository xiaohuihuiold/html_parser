import 'package:html_parser/exception/html_empty_exception.dart';
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

  /// 开始解析html
  void _parse() {
    if (_html == null || _html.length == 0) {
      throw HtmlEmptyException('html内容为空');
    }
    // 创建文档以及根元素
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
            // 发现element
            element = Element();
            i = _parseElementTag(element, ++i);
            if (!element.tag.toString().startsWith('!--')) {
              // 如果不是注释就添加到子节点
              parent.addElement(element);
              if (_html[i] == ' ') {
                // 标签后面如果是空格则说明可能有attribute
                i = _parseAttributes(element, ++i);
                // 解析完attribute后再获取id和class
                _parseElementID(element);
                _parseElementClass(element);
              }
              if (_html[i - 1] != '/' && _html[i] == '>') {
                // 解析element包裹的值,一般是文字
                i = _parseElementValue(element, i + 1);
              }
            } else {
              // 找到结束注释位置
              return [_findHtmlNoteEndIndex(i), 0];
            }
          } else {
            // 发现新的element
            // TODO: 待处理script和style
            if (element.tag == 'script' || element.tag == 'style') {
              continue;
            }
            Element temp = element;
            // 不需要解析子节点的标签
            switch (element.tag) {
              case 'meta':
              case 'link':
              case 'img':
                // 直接把新的element添加到当前element的父element
                temp = parent;
                break;
            }
            // 解析新的标签
            List<int> result = _parseElement(temp, --i);
            i = result[0];
            // 判断未闭合element跳过
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
          // 查找最近的一个element计算跳过层数
          while (test.tag != temp.tag) {
            temp = temp.parent;
            num++;
            if (temp == null) {
              // 已经到最顶层
              break;
            }
          }
          return [i, 0];
        }
      } else if (char == '/') {
        if (charNext == '>') {
          // 正常element结束
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
        // 标签名已经解析完成,需要进行下一步解析
        element.tag = tag;
        if (char == '/') {
          // 这里是element正常结束
          return i - 1;
        }
        // 可能还需要解析attribute
        return i;
      }
      // 获取标签名
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
        // 已经解析到标签末尾
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
        // 已经解析到标签末尾
        _parseAttributesKV(element, attr);
        return i + ((char == '/' && charNext == '>') ? 1 : 0);
      }
      // 获取的标签名到标签结束所有的值
      attr += char;
    }
    return i;
  }

  /// 解析属性值
  int _parseElementValue(Element element, int index) {
    int i = index;
    String value = '';
    for (; i < _html.length; i++) {
      String char = _html[i];
      if (char == '<') {
        value = value.trim();
        element.value = value.isEmpty ? null : value;
        return i - 1;
      } else {
        value += char;
      }
    }
    return i;
  }

  /// 解析属性详细
  void _parseAttributesKV(Element element, String attr) {
    if (attr == null || attr.length == 0) return;
    // 单引号或者双引号
    String mark = '';
    String name = '';
    String value = '';
    for (int i = 0; i < attr.length; i++) {
      String char = attr[i];
      // 过滤多个attribute之间的空格
      if (mark.isEmpty && char == ' ') {
        continue;
      }
      if (name.isEmpty) {
        // 最先开始解析的是name
        for (; i < attr.length; i++) {
          String char = attr[i];
          // TODO: 需要优化等号前排除多个空格
          if (char != '=') {
            // 如果没有等号
            if (char == ' ') {
              // 并且是下一个元素开始
              // 则说明当前attribute代表true
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
        // 此时name已经解析出来了
        for (; i < attr.length; i++) {
          String char = attr[i];
          if (char == '"' || char == "'") {
            // value通常是单引号或者双引号开始和结束
            if (mark.isEmpty) {
              // 记录value是单引号还是双引号
              mark = char;
            } else {
              // mark不为空并且当前是单引号或者双引号
              // 则说明当前value解析完成
              mark = '';
              element.putAttribute(name, value);
              name = '';
              value = '';
              break;
            }
          } else {
            if (mark.isNotEmpty) {
              // 被引号包裹的value
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
    // class按照一个或者多个空格分开
    List<String> classes =
        (element.getAttribute('class') as String)?.split(RegExp(r'\s+'));
    classes?.forEach((clazz) {
      element.addClass(clazz);
    });
  }

  /// 找出html注释结束位置
  int _findHtmlNoteEndIndex(int index) {
    int i = index;
    while (true) {
      String char = _html[i];
      String charNext = () {
        if (i + 1 < _html.length) {
          return _html[i + 1];
        }
        return null;
      }();
      i++;
      if (char == '-' && charNext == '>') {
        // 注释结束,找到跳过之后的下标
        return i;
      }
    }
  }
}
