import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'myModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      home: new MyStateful(),
    );
  }
}

class MyStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyStatefulState();
  }
}

class _MyStatefulState extends State<MyStateful> {
  final titleString = "JSON ListView";
  final urlJSONString = "http://androidthai.in.th/sun/json_example.json";

  List<MyModel> myAllData = [];

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(titleString),
      ),
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : showListView(),
    );
  }

  void loadData() async {
    var respense =
        await http.get(urlJSONString, headers: {"Aceept": "application/json"});
    if (respense.statusCode == 200) {
      String responseBodyString = respense.body;
      print('responseBodyString ==> ' + responseBodyString);
      var jsonBody = json.decode(responseBodyString);
      for (var data in jsonBody) {
        myAllData.add(new MyModel(
            data['id'], data['name'], data['email'], data['address']));
      }
      setState(() {
        myAllData.forEach((nameData) {
          print('name ==> ${nameData.nameString}');
        });
      });
    } else {
      print('Somethaing Wrong');
    }
  }

  showListView() {
    return new ListView.builder(
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return new Container(
            child: new Card(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new ListTile(
                    title: new Text('id ==> ${myAllData[index].idInt}'),
                    subtitle:
                        new Text('Name ==> ${myAllData[index].nameString}'),
                  ),
                  new Text('Email ==> ${myAllData[index].emailString}'),
                  new Text('Address ==> ${myAllData[index].addressString}')
                ],
              ),
            ),
          );
        });
  } // loadDate
}
