import 'package:html_parser/exception/element_exception.dart';

import 'element.dart';

class Document {
  // html根元素
  Element _root;

  get root => _root;

  set root(v) => _root = v;

  // 文档所有id元素
  Map<String, Element> _elementById;

  // 文档所有tag元素
  Map<String, List<Element>> _elementsByTag;

  // 文档所有class元素
  Map<String, List<Element>> _elementsByClass;

  /// 根据tag插入
  /// [tag] 元素标签名
  /// [element] 元素
  int insertElementByTag(Element element) {
    if (element == null) return -1;
    String tag = element.tag;
    if (tag == null || tag.length == 0) {
      throw ElementException.generate(
          ElementExceptionType.TAG_EMPTY, '元素标签名不能为空');
    }
    if (_elementsByTag == null) {
      _elementsByTag = Map();
    }
    List<Element> elements = _elementsByTag[tag];
    if (elements == null) {
      elements = List();
      _elementsByTag[tag] = elements;
    }
    elements.add(element);
    return elements.length;
  }

  /// 根据id插入
  /// [id] 元素id值
  /// [element] 元素
  int insertElementById(Element element) {
    if (element == null) return -1;
    String id = element.id;
    if (id == null || id.length == 0) {
      return -1;
    }
    if (_elementById == null) {
      _elementById = Map();
    }
    if (_elementById[id] != null) {
      throw ElementException.generate(
          ElementExceptionType.ID_REPEAT, '同一个文档中id值重复');
    }
    _elementById[id] = element;
    return _elementById.length;
  }

  /// 根据class插入
  /// [clazz] 元素其中一个class
  /// [element] 元素
  int insertElementByClass(String clazz, Element element) {
    if (element == null) return -1;
    if (clazz == null || clazz.length == 0) {
      return -1;
    }
    if (_elementsByClass == null) {
      _elementsByClass = Map();
    }
    List<Element> elements = _elementsByClass[clazz];
    if (elements == null) {
      elements = List();
      _elementsByClass[clazz] = elements;
    }
    elements.add(element);
    return elements.length;
  }

  /// 添加一个元素
  /// [element] 元素
  void insertElement(Element element) {
    if (element == null) return;
    element.root = this;
    insertElementByTag(element);
    insertElementById(element);
    List<String> classes = element.classes;
    if (classes == null) return;
    classes.forEach((clazz) => insertElementByClass(clazz, element));
  }

  /// 根据tag移除元素
  /// [element] 元素
  int removeElementByTag(Element element) {
    if (element == null) return -1;
    String tag = element.tag;
    if (tag == null || tag.length == 0) {
      return -1;
    }
    if (_elementsByTag == null) {
      return -1;
    }
    List<Element> elements = _elementsByTag[tag];
    if (elements == null) {
      return -1;
    }
    elements.remove(element);
    if (elements.length == 0) {
      elements = null;
      _elementsByTag[tag] = null;
    }
    return elements?.length;
  }

  /// 根据id移除元素
  /// [element] 元素
  int removeElementById(Element element) {
    if (element == null) return -1;
    String id = element.id;
    if (id == null || id.length == 0) {
      return -1;
    }
    if (_elementById == null) {
      return -1;
    }
    _elementById.remove(id);
    if (_elementById.length == 0) {
      _elementById = null;
    }
    return _elementById?.length;
  }

  /// 根据class移除元素
  /// [clazz] 元素class名
  /// [element] 元素
  int removeElementByClass(String clazz, Element element) {
    if (element == null) return -1;
    if (clazz == null || clazz.length == 0) {
      return -1;
    }
    if (_elementsByClass == null) {
      return -1;
    }
    List<Element> elements = _elementsByClass[clazz];
    if (elements == null) {
      return -1;
    }
    elements.remove(element);
    if (elements.length == 0) {
      elements = null;
      _elementsByClass[clazz] = null;
    }
    return elements?.length;
  }

  /// 移除一个元素
  /// [element] 元素
  void removeElement(Element element) {
    if (element == null) return;
    element.root = null;
    removeElementByTag(element);
    removeElementById(element);
    List<String> classes = element.classes;
    if (classes == null) return;
    classes.forEach((clazz) => removeElementByClass(clazz, element));
  }

  /// 根据id查找element
  /// [id] id
  Element getElementById(String id) {
    if (id == null || _elementById == null) {
      return null;
    }
    return _elementById[id];
  }

  /// 根据tag查找element
  /// [tag] 标签
  List<Element> getElementsByTag(String tag) {
    if (tag == null || _elementsByTag == null) {
      return List();
    }
    return _elementsByTag[tag];
  }

  /// 根据class查找element
  /// [clazz] 类名
  List<Element> getElementsByClass(String clazz) {
    if (clazz == null || _elementsByClass == null) {
      return List();
    }
    return _elementsByClass[clazz];
  }
}
