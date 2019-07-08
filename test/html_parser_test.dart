import 'package:flutter_test/flutter_test.dart';

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
  });
}
