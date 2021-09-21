
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api.dart';
import 'Expense Detail Page.dart';
import 'jsondecodeexpenses.dart';

class expensePage extends StatefulWidget {
  final Expense expense;
  final History data ;

  const expensePage({Key key, this.expense, this.data}) : super(key: key);
   @override
  _expensePageState createState() => _expensePageState(expense,data);
}

class _expensePageState extends State<expensePage> {
  List<History> recents = List();

  Expense _expense;
  final History data;

  _expensePageState(this._expense, this.data);
  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor:Color(0xff0277bd),
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
          "Expense",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
                onChanged: (string) {
                  //

                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(

                child: ListView.builder(
                    reverse: true,
                  itemCount: recents.length,
                    itemBuilder: (context, i){
                      History data = recents[i];

                      return Container(
                        height: 100,
                          child: Card(


                        child: ListTile(
                          title: Text(

                            "${data.merchant}",
                            style: TextStyle(
                                fontSize: 17, color: Colors.black),
                          ),

                          subtitle: Text(
                            "${data.employeeId}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),

                          trailing: Container(
                            width: 100,
                            height: 500,
                            padding: EdgeInsets.only(top:1),
                            child:Column(
                              children:[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:[

                                    SizedBox(width: 40,height: 10,),
                                    Text("${data.amount}",style: TextStyle(
                                        fontSize: 17, color: Colors.black),),
                                  ],
                                ),
                                Text('${data.status}',style: TextStyle(
                                    fontSize: 12, color: Colors.black),),
                              ],
                            ),
                          ),

                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                        detailPage(data: recents[i],),));

                          },

                        ),
                      )
                      );
                    }),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
