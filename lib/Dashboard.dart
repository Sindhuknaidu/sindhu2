import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'Expenses/expencedashboard.dart';
import 'Leave/applyleave.dart';
import 'main.dart';

void main() {
  runApp(new MaterialApp(

    home: DashboardPage(),
    debugShowCheckedModeBanner: false,
  ));
}
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  int currentIndex =0;

  Future<bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('You are going to exit the application!'),
            actions: <Widget>[
              FlatButton(
                  child:Text('No'),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  }
              ),
              FlatButton(
                  child:Text('Yes'),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  }
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,

        child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),color: Colors.black,
            onPressed: (){
              moveToLastScreen();
            },),
          backgroundColor: Color(0xff0277bd),
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
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          onItemSelected: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Home"),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black,
            ),

            BottomNavyBarItem(
              icon: Icon(Icons.people_alt_outlined),
              title: Text("People"),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black,
            ),

            BottomNavyBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              title: Text("More"),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black,
            ),
          ],
        ),
        body: Column(
          children: <Widget>[

            Container(
              width: double.maxFinite,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "ECS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome to ECS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(250)),
                color: Color(0xff0277bd),
              ),
            ),

            // StaggeredGridView.count(
            //   crossAxisCount:null
            // );
            // Expanded(
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 60,
                crossAxisSpacing: 10,
                primary: false,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                    child: new InkWell(
                      onTap: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/attendance.png'),
                          width: 64.0,
                        ),
                        //Image.network('https://pngimage.net/wp-content/uploads/2018/05/attendance-icon-png.png'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Attendance",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  ),

                  ),

                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Leave()));

                        },
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/Leave.png'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Leave",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  )
                  ),

                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => expanse()));

                        },
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/claims.png'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Claims",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  )
                   ),
                  Card(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {


                        },
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/payslips.png'),
                          width: 62.0,
                         ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Payslip",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  )
                  ),

                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {

                        },
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/skills.png'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Skills",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                    )
                  ),

                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                    child: new InkWell(
                    onTap: () {
                    },
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/company.png'),
                          width: 55.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Company\n Policies",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                    )
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {
                        },
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/messages.png'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Messages",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  )
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                    child: new InkWell(
                      onTap: () {
                        print("Personal Particulars");
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/personal.png'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Personal\nparticulars",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                    ),
                    elevation: 4,
                      child: new InkWell(
                        onTap: () {
                          print("Settings");
                        },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/settings.jpg'),
                          width: 64.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                    )
                  ),
                ],
              ),
            ),


          ],
        ),

      )
    );
  }
  Widget imageProfile() {
    return Container(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/profile.png')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 6.0,
            right: 7.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomsheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takephoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takephoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void moveToLastScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('You are going to exit the application!'),
            actions: <Widget>[
              FlatButton(
                  child:Text('No'),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  }
              ),
              FlatButton(
                  child:Text('Yes'),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  }
              ),
            ],
          );
        });
  }
}
