import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_app_bfd_1/article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
        },
        child: new ListView(
          children: _articles.map(_buildItem).toList(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article article){
    return new Padding(
      padding: EdgeInsets.all(16.0),
      child: new ExpansionTile(
        title: new Text(article.text),
        children: <Widget>[
          new Text("Bicara mengenai smartphone emang gak ada habisnya. Dari yang keluaran  terbaru dengan fitur paling canggih sampai smarphone kelas sultan yang berkilauan permata."),
          new IconButton(icon: Icon(Icons.launch), onPressed: () async {
            if(await canLaunch(article.domain)){
              launch(article.domain);
            }
          })
        ],
      ),
    );
  }
}
