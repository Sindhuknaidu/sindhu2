import 'package:final_hri_system/Api.dart' ;
import 'package:final_hri_system/Expenses/Expense%20Page.dart';
import 'package:final_hri_system/Expenses/editexpense.dart';
import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import 'jsondecodeexpenses.dart';


class detailPage extends StatefulWidget {
  final History data;
  const detailPage({Key key, this.data, }) : super(key: key);


  @override
  _detailPageState createState() => _detailPageState(data);
}

class _detailPageState extends State<detailPage> {
 History data;
 _detailPageState( this.data);


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
                    'Edit Expense',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => editexpense(widget.data)));
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
                    'delete epense',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {


                      setState(() {
                        _delete =   deleteexpense(widget.data.id.toString());

                      });
                      Navigator.pop(
                          context, MaterialPageRoute(builder: (context) => editexpense(widget.data)));

                      print("delete");
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => expensePage()));

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
        title:Text("Expense details",
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
                                 title: Text('${data.currencyId}',style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.bold),),
                                 subtitle: Text('Exchange Rate',style: TextStyle(fontSize:16,color:Colors.black54),),
                               ),
                               Divider(color: Colors.black,thickness: 0.5,height: 0.5,),
                               ListTile(
                                 title: Text("${data.description}",style: TextStyle(fontSize: 18,color:Colors.black87,fontWeight: FontWeight.w500),),
                                 subtitle: Text('Description',style: TextStyle(fontSize:16,color:Colors.black54),),
                               ),
                               Divider(color: Colors.black,thickness: 0.5,height: 0.5,),

                               Divider(color: Colors.black,thickness: 0.5,height: 0.5,),
                               ListTile(
                                 title: Text('${data.merchant}',style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.bold),),
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
                                         title: Text('Amount before Tax',),
                                         trailing: Text("${data.amount} ",style: TextStyle(fontSize: 16,color: Colors.black)),
                                       ),
                                     ),
                                     Container(
                                       height:35,
                                       child: ListTile(
                                         title: Text("Tax Amount ${data.currencyId}"),
                                         trailing: Text("${data.currencyId} ",style: TextStyle(fontSize: 16,color: Colors.black)),
                                       ),
                                     ),
                                     Container(
                                       height:30,
                                       child: ListTile(
                                         title: Text('Amount after GST'),
                                         trailing: Text(" ${data.amount}",style: TextStyle(fontSize: 16,color: Colors.black),),
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

