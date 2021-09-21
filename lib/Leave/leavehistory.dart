import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Api.dart';
import '../main.dart';
import 'jsondecodeallstatus.dart';
import 'leavedetail.dart';


class allstatus extends StatefulWidget {
  final Leaf leaf;

  const allstatus({Key key, this.leaf}) : super(key: key);
  @override
  _allstatusState createState() => _allstatusState();
}

class _allstatusState extends State<allstatus> {

  List<Leaf> allstatuslist = List();
  Allstatus _allstatus;
  String status;

  Color getColor(){
    if(status=='Approved'){
      return Colors.green;
    }
    if(status=='Reject'){
      return Colors.red;
    }
    else{
      Colors.orange;
    }
  }
  @override
  void initState(){
    super.initState();
    Servicesallstatus.getStatus().then((allstatus) {
      _allstatus = allstatus;
      print(_allstatus.data.leaves.length);
      setState(() {
        allstatuslist = _allstatus.data.leaves;
      });
    });
  }
  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                print(widget.leaf.leaveId.toString());
        setState(() {
  deleteleave(widget.leaf.leaveId.toString());
});

                print("delete");
                 },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.lightBlue[100],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => MaterialApp()));
            },
          ),
          centerTitle: true,
          title: Text(
            "Leave History",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                FlutterSession().set('token','null');
                Fluttertoast.showToast(
                    msg: "Logout Successful",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,

                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                  child: Text(
                    "Pending Status",
                    style: TextStyle(color: Colors.blue),
                  )),
              Tab(
                child: Text(
                  "All Status",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: allstatuslist.length,
                    itemBuilder: (context, index) {
                      Leaf request = allstatuslist[index];
                      return Card(
                        child: ListTile(
                            title: Text(
                              "${request.remarks}",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${"Total leave    "+request.totalLeave}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),


                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                  '${request.fromDate}',
                                      style: TextStyle(
                                          fontSize: 15, color: getColor()),
                                    ),
                                    Text(
                                      '${request.toDate}',
                                      style: TextStyle(
                                          fontSize: 15, color: getColor()),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            leading: Container(
                              width: 55,
                              height: 66,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            isThreeLine: true,
                            onTap: () {

                            }),
                      );
                    }),
              ),
            ),
            Container(
              child: Column(
                  children: [
                    Container(
                      decoration:BoxDecoration(color: Colors.white),
                      margin: EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                            ),
                            hintText: ('Search'),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30.0))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: allstatuslist.length,
                            itemBuilder: (context, index) {
                              Leaf request = allstatuslist[index];
                              return Card(
                                child: ListTile(
                                    title: Text(
                                      "Total leaves: ${request.totalLeave}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${request.remarks}",
                                              style: TextStyle(
                                                  fontSize: 17, color: Colors.black),
                                            ),
                                            Text(
                                              status='${request.status}',
                                              style: TextStyle(
                                                  fontSize: 15, color: getColor()),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    leading: Container(
                                      width: 55,
                                      height: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    isThreeLine: true,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => leavedetail(data: allstatuslist[index],)));
                                    }),
                              );
                            }),
                      ),
                    ),
                  ]),
            )],
        ),
      ),
    );
  }
}


