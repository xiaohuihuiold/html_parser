import 'package:flutter/material.dart';
import 'package:html_parser/html_parser.dart';

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
  Future<void> _loadHtml() async {
    XmlParser xmlParser = XmlParser.html('''
    <html>
    <head>
      <title>测试页面</title>
    </head>
    <body>
      
    </body>
    </html>
    ''');
  }

  void _onFrame(_) {}

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
        itemCount: 40,
        physics: BouncingScrollPhysics(),
        itemBuilder: (buildContext, index) {
          return ListTile(
            title: Text('title'),
            subtitle: Text('sub'),
          );
        },
      ),
    );
  }
}
