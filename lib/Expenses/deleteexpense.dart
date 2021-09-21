import 'dart:async';
import 'dart:convert';

import 'package:final_hri_system/Expenses/jsondecodeexpensedetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Expense> fetchexpense() async {
  final response = await http.get(
    Uri.parse('https://sgitjobs.com/EcsAdminPanel/public/api/cancel/expense/{id}'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Expense.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Expense> delete(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Expense.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

class Expense {
  final int id;
  final String title;

  Expense({this.id, this.title});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
    );
  }
}


class Deleteexpense extends StatefulWidget {
  const Deleteexpense({Key key}) : super(key: key);

  @override
  _DeleteexpenseState createState() {
    return _DeleteexpenseState();
  }
}

class _DeleteexpenseState extends State<Deleteexpense> {
  Future<Expense> _fetchexpense;

  @override
  void initState() {
    super.initState();
    _fetchexpense = fetchexpense();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Delete Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Expense>(
            future: _fetchexpense,
            builder: (context, snapshot) {
              // If the connection is done,
              // check for response data or an error.
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.title ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _fetchexpense =
                                delete(snapshot.data.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}