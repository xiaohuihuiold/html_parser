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

  set tag(v) {
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

  set id(v) {
    if (_root == null) {
      _id = v;
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

  /// 添加class
  /// [clazz] 元素类名
  int addClass(String clazz) {
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
    classes.forEach((clazz) => addClass(clazz));
    _elements?.forEach((element) => element.updateToDocument());
  }

  /// 移除信息从document
  void removeFromDocument() {
    _root.removeElement(this);
    _elements?.forEach((element) => element.removeFromDocument());
  }
}