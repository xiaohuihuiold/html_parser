import 'package:html_parser/exception/element_root_null_exception.dart';

import 'document.dart';

class Element {
  // 根节点
  Document _root;

  get root => _root;

  set root(v) => _root = v;

  // 父节点
  Element _parent;

  get parent => _parent;

  set parent(v) => _parent = v;

  // 元素tag
  String _tag;

  get tag => _tag;

  set tag(String v) {
    v = v?.toLowerCase()?.trim();
    if (_root == null) {
      _tag = v;
      return;
    }
    if (_tag != null) {
      _root.removeElementByTag(this);
    }
    _tag = v;
    _root.insertElementByTag(this);
  }

  // 元素id
  String _id;

  get id => _id;

  set id(String v) {
    if (_root == null) {
      _id = v?.toLowerCase()?.trim();
      return;
    }
    if (_id != null) {
      _root.removeElementById(this);
    }
    _id = v;
    _root.insertElementById(this);
  }

  // 元素class
  List<String> _classes;

  get classes => _classes;

  // 每一个元素都可能有多个子元素
  List<Element> _elements;

  get elements => _elements;

  // 元素属性列表
  Map<String, dynamic> _attributes;

  get attributes => _attributes;

  /// 添加class
  /// [clazz] 元素类名
  int addClass(String clazz) {
    clazz = clazz?.toLowerCase()?.trim();
    if (clazz == null || clazz.length == 0) {
      return -1;
    }
    if (_classes == null) {
      _classes = List();
    }
    if (_classes.contains(clazz)) {
      _classes.remove(clazz);
      _root?.removeElementByClass(clazz, this);
    }
    _classes.add(clazz);
    _root?.insertElementByClass(clazz, this);
    return _classes.length;
  }

  /// 移除class
  /// [clazz] 元素类名
  int removeClass(String clazz) {
    clazz = clazz?.toLowerCase();
    if (clazz == null ||
        clazz.length == 0 ||
        _classes == null ||
        !_classes.contains(clazz)) {
      return -1;
    }
    _classes.remove(clazz);
    _root?.removeElementByClass(clazz, this);
    if (_classes.length == 0) {
      _classes = null;
    }
    return _classes?.length;
  }

  /// 添加元素属性
  /// [name] 属性名
  /// [value] 值
  int putAttribute(String name, dynamic value) {
    name = name?.toLowerCase()?.trim();
    if (_attributes == null || name == null) {
      _attributes = Map();
    }
    _attributes[name] = value;
    return _attributes.length;
  }

  /// 移除元素属性
  /// [name] 属性名
  int removeAttribute(String name) {
    name = name?.toLowerCase();
    if (_attributes == null || name == null) {
      return -1;
    }
    _attributes.remove(name);
    return _attributes.length;
  }

  /// 查找元素属性
  /// [name] 属性名
  dynamic getAttribute(String name) {
    name = name?.toLowerCase();
    if (_attributes == null || name == null) {
      return null;
    }
    return _attributes[name];
  }

  /// 获取所有属性名
  List<String> getAttributeNames() {
    return _attributes?.keys;
  }

  /// 添加子元素到最后一个
  int addElement(Element element) {
    if (_elements == null) {
      _elements = List();
    }
    _elements.add(element);
    element.parent = this;
    if (root != null) {
      _root.insertElement(element);
      element.updateToDocument();
    }
    return _elements.length;
  }

  /// 添加子元素到指定位置
  /// [index] 位置
  int addElementAt(int index, Element element) {
    if (index < 0) {
      return -1;
    }
    if (_elements == null) {
      _elements = List();
    }
    _elements.insert(index, element);
    element.parent = this;
    if (root != null) {
      _root.insertElement(element);
      element.updateToDocument();
    }
    return _elements.length;
  }

  /// 移除子元素
  int removeElement(Element element) {
    if (_elements == null) {
      return -1;
    }
    _elements.remove(element);
    element.parent = null;
    if (root != null) {
      element.removeFromDocument();
    }
    return _elements.length;
  }

  /// 移除指定位置子元素
  /// [index] 位置
  int removeElementAt(int index) {
    if (_elements == null || index < 0 || index >= _elements.length) {
      return -1;
    }
    Element element = _elements[index];
    _elements.remove(element);
    element.parent = null;
    if (root != null) {
      element.removeFromDocument();
    }
    return _elements.length;
  }

  /// 更新元素信息到document
  void updateToDocument() {
    tag = _tag;
    id = _id;
    List<String> classes = this.classes;
    this._classes = null;
    classes?.forEach((clazz) => addClass(clazz));
    _elements?.forEach((element) => element.updateToDocument());
  }

  /// 移除信息从document
  void removeFromDocument() {
    _root.removeElement(this);
    _elements?.forEach((element) => element.removeFromDocument());
  }

  /// 根据id查找element
  /// [id] id值
  Element getElementById(String id) {
    if (_root == null) {
      throw ElementRootNullException('根节点为空');
    }
    id = id?.toLowerCase();
    return _root.getElementById(id);
  }

  /// 根据标签查找elements
  /// [tag] 标签
  List<Element> getElementsByTag(String tag) {
    tag = tag?.toLowerCase();
    List<Element> elements = List();
    _elements?.forEach((element) {
      if (element.tag == tag) {
        elements.add(element);
      }
      elements += element?.getElementsByTag(tag);
    });
    return elements;
  }

  /// 根据class查找elements
  /// [clazz] 类名
  List<Element> getElementsByClass(String clazz) {
    clazz = clazz?.toLowerCase();
    List<Element> elements = List();
    _elements?.forEach((element) {
      List<String> classes = element.classes;
      if (classes?.contains(clazz) ?? false) {
        elements.add(element);
      }
      elements += element?.getElementsByClass(clazz);
    });
    return elements;
  }

  /// 打印所有节点
  /// [depth] 深度
  void printAll([int depth]) {
    if (depth == null) {
      depth = 0;
    }
    print('${'-' * depth}${this.toString()}');
    depth++;
    _elements?.forEach((element) => element.printAll(depth));
  }

  @override
  String toString() {
    String id = this._id == null ? '' : 'id:${this._id}';
    String clazz = this._classes == null
        ? ''
        : '${(id == null || id.isEmpty) ? '' : ' '}class:${this._classes}';
    String str;
    str = '($id$clazz)';
    if (id.isEmpty && clazz.isEmpty) {
      str = '';
    }
    return '$tag $str';
  }
}
