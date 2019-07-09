import 'package:flutter_test/flutter_test.dart';
import 'package:html_parser/html/document.dart';
import 'package:html_parser/html/element.dart';

import 'package:html_parser/html_parser.dart';

String testHtml = '''
<!DOCTYPE html>
<html>
    <head>
        <title>测试html</title>
    </head>
    <body>
        <p>这是一段测试html文字</p>
    </body>
</html>
''';

void main() {
  test('html parser test', () {
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
      p.id='$i';
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

    Element id=root.getElementById('5');
    print(id);
  });
}
