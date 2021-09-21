import 'package:final_hri_system/Leave/jsondecodeapplyleave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../Api.dart';
import '../main.dart';
import 'leavehistory.dart';

class getdata {
  String leave_type;
  String from_date;
  String to_date;
  String from_section;
  String to_section;
  String remarks;
  String total_leave;


  getdata({
    @required this.leave_type,
    @required this.from_date,
    @required this.to_date,
    @required this.from_section,
    @required this.to_section,
    @required this.remarks,
    @required this.total_leave,


  });
}



class Leave extends StatefulWidget {
  final ApplyLeave data;

  const Leave({Key key, this.data}) : super(key: key);
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  String Annual='Select';
  String Balance='0';
  String difference='0';

  String From;
  String To;
  String Am="am";
  String Pm="pm";


  DateTime from_dateController = DateTime.now();
  DateTime to_dateController = DateTime.now();

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: from_dateController,
      initialLastDate: to_dateController,
      firstDate: new DateTime(DateTime.now().year - 50),
      lastDate: new DateTime(DateTime.now().year + 50),
    );


    if (picked != null && picked.length == 2) {
      setState(() {
        to_dateController = picked[0];
        to_dateController = picked[1];
      });
    }
    setState(() {
      difference = '${to_dateController.difference(from_dateController).inDays + 1}';
      print(difference);
    });
  }
  var leave_typeController = new TextEditingController();
  var from_sectionController = new TextEditingController();
  var to_sectionController = new TextEditingController();
  var remarksController = new TextEditingController();
  var total_leaveController = new TextEditingController();
  Future postData() async{
    try {
      String token = await getToken();

      String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/applyLeave';
      var headers = { HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };
      var body = jsonEncode({

        "from_date": from_dateController.toString(),
        "to_date": to_dateController.toString(),
        "from_section":from_sectionController.text,
        "to_section":to_sectionController.text,
        "leave_type":leave_typeController.text,
        "remarks":remarksController.text,
        "total_leave":total_leaveController.text,
      });
      final response = await http.post(url,
          headers: headers,
          body: body
      );
      var data=json.decode(response.body);
      print(response.statusCode);
      print(response.body);
      print(data);
    }catch(er){}
  }
  // show Bottomsheed in More

  void showBottomMore(context) {
    //bottom sheet on More function
    print('hi');
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text(
                    'Leave Summary',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => leavesummary()));*/
                  },
                ),
                Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    'Leave History',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => allstatus()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
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
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        });
  }

  // show Bottomsheed in dropdown
  void showBottomDrop(context) {
    //bottom sheet on More function
    print('hi');
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: RequestList.length,
                  itemBuilder: (context, index) {
                    leavetype request = RequestList[index];
                    return Card(
                      child: ListTile(
                        title: Text(request.Type),
                        trailing: Text(request.day),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            leave_typeController.text = request.Type ;
                            Balance = request.day;
                          });
                        },
                      ),
                    );
                  }),
            ),
          );
        });
  }

  String name = "";
  final _controller1 = TextEditingController();
  String email = "";

  String Days = "Days";
  String Hours = "";

  int selectedRadio;
  int selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.white54,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            color: Colors.black,
            onPressed: () {}),
        centerTitle: true,
        title: Text(
          ' Apply Leave',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 6.0,
              right: 8.0,
            ),
            child: Container(
              child: FlatButton(
                textColor: Colors.white,
                child: Text(
                  "More",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  showBottomMore(context);
                },
                shape:
                CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ),
          ),


          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              FlutterSession().set('token','null');

              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 900,
              height: 320,
              margin: EdgeInsets.only(
                top: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: Container(
                      child: Text(
                        'Leave Type',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),),
                    trailing:Container(
                      height: 20,

                      child: Text(
                        "",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                    ),
                    onTap: () {
                      showBottomDrop(context);
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: ListTile(
                      title: Text(
                        'Leave Balance',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      trailing: Text(
                        '${Balance}',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FROM',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      child: Text(
                                        "${DateFormat.d().format(from_dateController).toString()}",
                                        style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontSize: 40),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 1.0,
                                            bottom: 1.0,
                                          ),
                                          margin: EdgeInsets.only(left: 1),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 1,
                                                    right: 95,
                                                    left: 1),
                                                child: Text(
                                                  "${DateFormat.E().format(from_dateController).toString()}",
                                                  style:
                                                  TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: -12,
                                                right: -10,
                                                left: -3,
                                                top: -8,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.5,
                                                      child: LiteRollingSwitch(
                                                        value: true,
                                                        textOn: "AM",
                                                        textOff: "PM",
                                                        colorOn: Colors.green[400],
                                                        colorOff: Colors.blue[500],
                                                        iconOn: Icons.wb_sunny_outlined,
                                                        iconOff: Icons.wb_sunny_sharp,
                                                        textSize: 20.0,
                                                        onChanged: (bool position) {
                                                          if(position == true){
                                                            print(From="${DayPeriod.am}");
                                                            From="${Am}";

                                                          }
                                                          else if (position == false){
                                                            print(From="${DayPeriod.pm}");
                                                            From="${Pm}";

                                                          }

                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${DateFormat.MMM().format(from_dateController).toString()}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.pinkAccent),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${DateFormat.y().format(from_dateController).toString()}",
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          await displayDateRangePicker(context);
                        },
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 1.0,
                            bottom: 2.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 47,
                                    child: Text(
                                      "${DateFormat.d().format(to_dateController).toString()}",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 40),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 1.0,
                                          bottom: 2.0,
                                        ),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 1,
                                                  right: 95,
                                                  left: 1),
                                              child: Text(
                                                "${DateFormat.E().format(to_dateController).toString()}",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -10,
                                              right: -25,
                                              left: -20,
                                              top: -8,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                    scale: 0.5,
                                                    child: LiteRollingSwitch(
                                                      value: true,
                                                      textOn: "AM",
                                                      textOff: "PM",
                                                      colorOn: Colors.green[400],
                                                      colorOff: Colors.blue[500],
                                                      iconOn: Icons.wb_sunny_outlined,
                                                      iconOff: Icons.wb_sunny_sharp,
                                                      textSize: 20.0,
                                                      onChanged: (bool position) {
                                                        if(position == true){
                                                          print(To="${Am}");
                                                          To="${Am}";
                                                        }
                                                        else if (position == false){
                                                          print(To="${Pm}");
                                                          To="${Pm}";
                                                        }

                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${DateFormat.MMM().format(to_dateController).toString()}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.pinkAccent),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${DateFormat.y().format(to_dateController).toString()}",
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          await displayDateRangePicker(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      bottom: 2,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Leave Unit",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          width: 125,
                          child: RadioListTile(
                            value: 0,
                            title: Text('Days'),
                            groupValue: from_sectionController,
                            onChanged: (val) {
                              print("ratio tile pressed $val");
                              setSelectedRadioTile(val);
                              setState(() {
                                //                            from_sectionController.text = "days" ;
                              });
                            },
                            activeColor: Colors.indigo,
                            selected: true,
                          ),
                        ),
                        Container(
                          width: 135,
                          child: RadioListTile(
                            title: Text('Hours'),
                            value: 1,
                            groupValue: to_sectionController,
                            onChanged: (val) {
                              setSelectedRadioTile(val);
                              setState(() {
                                //                            to_sectionController.text = 'Hours';
                              });
                            },
                            activeColor: Colors.indigo,
                            selected: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          bottom: 2,
                        ),
                        child: Text(
                          'No.of ${Days}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 220.0,
                          bottom: 5.0,
                        ),
                        child: Text(
                          '${difference}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          'Recommender',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Text(
                          'V.R Nagarajan',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          'Approver',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          width: 163,
                        ),
                        Text(
                          'V.R Nagarajan',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          'CC',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          width: 145,
                        ),
                        Container(
                          width: 175,
                          height: 45,
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            email,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showAddNoteDialog(context),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: InkWell(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Add Remark',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 155,
                        height: 45,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => _showAddNoteDialogRemark(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child:
              ButtonBar(buttonHeight: 50, buttonMinWidth: 1000, children: [
                FlatButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: Colors.black45,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Add Attachment',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    onPressed: () {

                    }),
              ]),
            ),
            Container(),
            SizedBox(
              height: 55,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              buttonMinWidth: 350,
              buttonHeight: 50,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () async {
                    print("pressed");
                    setState(() {
                      total_leaveController.text=difference.toString();
                    });

                    var leaveType = leave_typeController.text;
                    var fromDate = from_dateController.toString();
                    var toDate = to_dateController.toString();
                    var fromSection = from_sectionController.text;
                    var toSection = to_sectionController.text;
                    var totalLeave = total_leaveController.text;
                    var Remarks = remarksController.text;


                    var rsp = await leave(leaveType,fromDate,toDate,fromSection,toSection,totalLeave,Remarks);
                    print(rsp);

                    if (rsp.containsKey('success') == true) {
                      print(rsp);
                      if (rsp['success'] == true) {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => allstatus()));

                      }

                      else {
                      }
                    }
                  },
                  color: Colors.lightGreen[300],
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showAddNoteDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            width: 900,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add CC',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Separate list with(,)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: _controller1,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.red,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FlatButton(
                        minWidth: 125,
                        height: 45,
                        onPressed: () {

                          Navigator.of(context).pop();
                          print("rsp");
                        },
                        child: Text('CANCEL',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.indigo[600],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        minWidth: 125,
                        height: 45,

                        onPressed: () async {
                          print("pressed");

                        },

                        child: Text('',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.indigo[600],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });

  _showAddNoteDialogRemark(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return Container(
          width: 600,
          height: 800,
          child: AlertDialog(
            title: Text(
              'Add Remark',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller: remarksController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Type Reason For Your Leave'),
                      cursorColor: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        FlatButton(
                          minWidth: 125,
                          height: 45,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('CANCEL',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          color: Colors.indigo[600],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          minWidth: 125,
                          height: 45,
                          onPressed: () {
                            print('hi');
                            setState(() {
                              name = remarksController.text;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Done',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          color: Colors.indigo[600],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });

  _showAddNoteDialogSubmit(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return Container(
          width: 600,
          height: 800,
          child: AlertDialog(
            content: Container(
              width: 800,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.thumb_up_rounded,
                    size: 70,
                    color: Colors.lightGreenAccent[400],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Great!',
                    style:
                    TextStyle(fontSize: 17, color: Colors.lightGreen[300]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Your leave application has been submitted.',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.lightGreen[300],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    autofocus: true,
                    splashColor: Colors.lightGreen[300],
                    onPressed: () {
                      print('hi');
                      Navigator.of(context).pop();
                    },
                    child: Text('Close',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17,
                        )),
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

class SwitchScreen extends StatefulWidget {
  SwitchScreen({Key key}) : super(key: key);

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.5,
          child: LiteRollingSwitch(
            value: true,
            textOn: "AM",
            textOff: "PM",
            colorOn: Colors.green[400],
            colorOff: Colors.blue[500],
            iconOn: Icons.wb_sunny_outlined,
            iconOff: Icons.wb_sunny_sharp,
            textSize: 25.0,
            onChanged: (bool position) {
              print("The button is $position");
            },
          ),
        ),
      ],
    );
  }
}

class leavetype {
  String Type;
  String day;

  leavetype({
    @required this.Type,
    @required this.day,
  });
}

List<leavetype> RequestList = [
  leavetype(Type: 'Annual', day: '5'),
  leavetype(Type: 'Annual Leave', day: '10'),
  leavetype(Type: 'Balik Kampong Leave', day: '20'),
  leavetype(Type: 'Examination Leave', day: '60'),
  leavetype(Type: 'FWA Leave', day: '15'),
  leavetype(Type: 'Hospital', day: '24'),
  leavetype(Type: 'Hospitalisation Leave', day: '10'),
  leavetype(Type: 'In Camp Leave', day: '21'),
  leavetype(Type: 'In Camp Training', day: '30'),
  leavetype(Type: 'Marrage', day: '20'),
  leavetype(Type: 'Maternity', day: '35'),
  leavetype(Type: 'No pay', day: '50'),
  leavetype(Type: 'Off In Lieu', day: '5'),
  leavetype(Type: 'Sick Leave', day: '25'),
  leavetype(Type: 'Urgent Leave', day: '1'),
  leavetype(Type: 'WFH', day: '50'),
];
