import 'package:flutter_test/flutter_test.dart';
import 'package:html_parser/html/document.dart';
import 'package:html_parser/html/element.dart';

import 'package:html_parser/html_parser.dart';

String testHtml = '''
<html>
    <head>
        <title>测试html
    </head>
    <body>
        <div>
          <p>这是一段测试html文字
           <h>这是一段测试html文字</h>
        </div>
        <p>测试</p>
    </body>
</html>
''';

void main() {
  test('html parser', () {
    Element root = Element();
    root.tag = 'root';
    testParser(root, 0);
    root?.printAll();
  });
  test('dom test', () {
    XmlParser xmlParser = XmlParser.html(testHtml);
    Document document = Document();
    Element root = Element();
    root.tag = 'html';
    document.root = root;

    Element head = Element();
    head.tag = 'head';
    root.addElement(head);

    Element title = Element();
    title.tag = 'title';
    head.addElement(title);

    for (int i = 0; i < 7; i++) {
      Element p = Element();
      p.tag = 'p';
      title.addElement(p);
      p.id = '$i';
    }

    Element body = Element();
    body.tag = 'body';
    root.addElement(body);

    for (int i = 0; i < 5; i++) {
      Element p = Element();
      p.tag = 'p';
      body.addElement(p);
    }

    document.printAll();

    Element id = root.getElementById('5');
    print(id);
  });
}

List<int> testParser(Element parent, int index) {
  int i = index;
  for (; i < testHtml.length; i++) {
    String char = testHtml[i];
    if (char == '<') {
      if (testHtml[i + 1] == '/') {
        i += 2;
        String tag = '';
        while (i < testHtml.length && testHtml[i] != '>') {
          tag += testHtml[i];
          i++;
        }
        if (parent.tag != tag) {
          return [i++, 1];
        }
        break;
      }
      Element element = Element();
      String tag = '';
      i++;
      while (
          i < testHtml.length && (testHtml[i] != ' ' && testHtml[i] != '>')) {
        tag += testHtml[i];
        i++;
      }
      element.tag = tag;
      parent.addElement(element);
      List<int> nums = testParser(element, ++i);
      i = nums[0];
      if (nums[1] > 0) {
        nums[1] = nums[1] - 1;
        return nums;
      }
    }
  }
  return [i + 2, 0];
}
