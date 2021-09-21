import 'package:final_hri_system/Expenses/editexpense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Api.dart';
import '../Dashboard.dart';
import '../main.dart';
import 'Expense Page.dart';
import 'addexpense.dart';
import 'jsondecodeexpenses.dart';

class expanse extends StatefulWidget {

  @override
  _expanseState createState() => _expanseState();
}

class _expanseState extends State<expanse>  {

  List<History> recents = List();
  Expense _expense;
  Data _data ;


  void initState(){
    super.initState();
    Services.getExpense().then((expanse) {
      _expense = expanse;
      print(_expense.data.histories.length);
setState(() {
  recents = _expense.data.histories;
});
    });
  }
  void showBottomMore(context) {
    //bottom sheet on More function
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text(
                    'Add Expenses',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>addexpense()));
                  },
                ),
                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    'Expenses',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>expensePage()));
                  },
                ),
                

                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                  },
                ),
                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),

              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:120,
        title: new Text('Expanse'),
        centerTitle: true,
        leading:IconButton(icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DashboardPage()));
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_outlined),
            onPressed: () {
              showBottomMore(context);
            },
          ),

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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color:  Color(0xff0277bd),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:20.0,right: 8.0,left: 8.0),
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),

                elevation: 15,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text(
                          '',
                          style:
                          TextStyle(fontSize: 25.0, color: Colors.teal),
                        ),
                      ),
                      title: Text(
                        'Unreported',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
                      ),
                      subtitle: Text(
                        'Expenses',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),

                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(left:20.0),
                        child: Text(
                          '',
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                      title: Text(
                        'Unsubmitted',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
                      ),
                      subtitle: Text(
                        'Reports',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),

                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(left:20.0),
                        child: Text(
                          '',
                          style:
                          TextStyle(fontSize: 25.0, color: Colors.green),
                        ),
                      ),
                      title: Text(
                        'Pending Approvals',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
                      ),
                      subtitle: Text(
                        'Approvals',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:40),
              Text("Recent",style:TextStyle(fontSize:20,color: Colors.black,fontWeight: FontWeight.bold)),

        Container(
          color:Colors.white60,
          height: 350,

          child: ListView.builder(
            reverse: true,
            itemCount: recents.length,
              itemBuilder: (context, i){
                History data = recents[i];

              return GestureDetector(
               child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),

                  elevation: 20,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(

                        title:Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Created Expenses with the amount of   ${data.amount}',
                            style:
                            TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ),

                        subtitle: Text(
                          '${data.description}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),



              );

            },
            padding: const EdgeInsets.only(bottom:6.0,left: 10,right:10),
    ),

  ),


  ]
        ),


          ),

      ),
    );
  }
}
