
import 'package:final_hri_system/Api.dart' ;
import 'package:final_hri_system/Leave/jsondecodeallstatus.dart';
import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import 'leavehistory.dart';


class leavedetail extends StatefulWidget {
  final Leaf data;
  const leavedetail({Key key, this.data, }) : super(key: key);


  @override
  _leavedetailState createState() => _leavedetailState(data);
}

class _leavedetailState extends State<leavedetail> {
  Leaf data;
  _leavedetailState( this.data);


  @override
  void initState();
  Future _delete = Services.getExpense();

  @override

  void showBottomMore(context) {
    //bottom sheet on More function
    print('More');
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text(
                    'Edit Leave',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                       },
                ),
                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    'delete leave',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    setState(() {
                      _delete =   deleteleave(widget.data.leaveId.toString());
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => allstatus()));
                    });
                  },

                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
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
        backgroundColor: Colors.lightBlue[300],
        toolbarHeight: 100,
        leadingWidth: 0.5,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
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
        title:Text("Leave details",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: DefaultTabController(
        length:2,
        child:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(5.0),
              ),
              constraints: BoxConstraints(maxHeight:40.0,maxWidth: 320),
              child:Material(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],

              ),
            ),
            Expanded(
              child: Container(
                child:    SingleChildScrollView(
                  child:Container(
                    margin: EdgeInsets.all(5.0),
                    child: Column(
                      children:[
                        ListTile(
                          title: Text('${data.remarks}',style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.bold),),
                          subtitle: Text('Remarks',style: TextStyle(fontSize:16,color:Colors.black54),),
                        ),
                        Divider(color: Colors.black,thickness: 0.5,height: 0.5,),
                        ListTile(
                          title: Text("${data.totalLeave}",style: TextStyle(fontSize: 18,color:Colors.black87,fontWeight: FontWeight.w500),),
                          subtitle: Text('Total number of leaves',style: TextStyle(fontSize:16,color:Colors.black54),),
                        ),
                        Divider(color: Colors.black,thickness: 0.5,height: 0.5,),

                        Divider(color: Colors.black,thickness: 0.5,height: 0.5,),
                        ListTile(
                          title: Text('${data.leaveType}',style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.bold),),
                          subtitle: Text('Customer Name',style: TextStyle(fontSize:16,color:Colors.black54),),
                        ),
                        Divider(color: Colors.black,thickness: 0.5,height: 0.5,),
                        SizedBox(height: 10,),
                        Container(
                          height: 120,
                          margin: EdgeInsets.all(2.0),
                          color:Colors.grey[200],
                          child:Column(
                            children: [
                              Container(
                                height:30,
                                child: ListTile(
                                  title: Text('From date',),
                                  trailing: Text("${data.fromDate} ",style: TextStyle(fontSize: 16,color: Colors.black)),
                                ),
                              ),

                              Container(
                                height:30,
                                child: ListTile(
                                  title: Text('To date'),
                                  trailing: Text(" ${data.toDate}",style: TextStyle(fontSize: 16,color: Colors.black),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),





              ),),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        label: Text('More Details',style:TextStyle(fontSize: 15),),
        onPressed: (){
          showBottomMore(context);
        },
      ),
    );
  }
}

