import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html_parser/html_parser.dart' hide Element;
import 'package:html_parser/html/element.dart' as html;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTML Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> plugins = List();

  Future<void> _loadHtml() async {
    Dio dio = Dio();
    Response response = await dio.get('https://pub.flutter-io.cn/');
    XmlParser xmlParser = XmlParser.html(response.data);
    Document document = xmlParser.document;
    List<html.Element> elements = document.getElementsByClass('list-item');
    elements.forEach((ele) {
      html.Element title =
          ele.getElementsByClass('title')[0].getElementsByTag('a')[0];
      html.Element desc = ele.getElementsByClass('description')[0];
      plugins.add({
        'title': title.value,
        'desc': desc.value,
      });
    });
    setState(() {
      plugins = plugins;
    });
  }

  void _onFrame(_) {
    _loadHtml();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('html'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: plugins.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (buildContext, index) {
          return ListTile(
            leading: Icon(Icons.extension),
            title: Text(
              plugins[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(plugins[index]['desc']),
          );
        },
      ),
    );
  }
}
