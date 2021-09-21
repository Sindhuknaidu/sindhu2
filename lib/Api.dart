import 'dart:io';

import 'package:final_hri_system/Leave/leavehistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'Expenses/jsondecodeexpenses.dart';
import 'Leave/jsondecodeallstatus.dart';
import 'Leave/jsondecodeapplyleave.dart';
import 'main.dart';

DateTime selectdateController = DateTime.now();
var  claimsController = new TextEditingController();
var taxController = new TextEditingController();
var merchantController = new TextEditingController();
var remarksController = new TextEditingController();
var descriptionController = new TextEditingController();
var amountController = new TextEditingController();
Future claimData() async {
  try{
  String token = await getToken();

  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/add/expense';
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var body = jsonEncode({
    "category_id": claimsController,
    "amount": amountController,
    "date":selectdateController.toString(),
    "merchant":merchantController,
    "tax":taxController,
    "description":descriptionController,
    "attachments":remarksController
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

Future claim(String claims,
    String amount,
    String selectdate,
    String merchant,
    String tax,
    String description,
    String reporttype ) async {
  String token = await getToken();

  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/add/expense';
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var body = jsonEncode({
    "category_id":claims,
    "amount": amount,
    "date":selectdate,
    "merchant":merchant,
    "tax":tax,
    "description":description,
    "attachments":reporttype
  });

  final response = await http.post(url,
      headers: headers,
      body: body
  );
  print(response.statusCode);
  var convertedDatatoJson = jsonDecode(response.body);
  print(convertedDatatoJson);
  return convertedDatatoJson;
}
Future leave(String fromDate, String toDate, String fromSection, String toSection,String leaveType, String Remarks, String totalLeave
    ) async {
  String token = await getToken();

  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/applyLeave';
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var body = jsonEncode({

    "from_date": fromDate,
    "to_date": toDate,
    "from_section":fromSection,
    "to_section":toSection,
    "leave_type":leaveType,
    "remarks":Remarks,
    "total_leave":totalLeave
  });

  final response = await http.post(url,
      headers: headers,
      body: body
  );
  print(response.statusCode);
  var convertedDatatoJson = jsonDecode(response.body);
  print(convertedDatatoJson);
  return convertedDatatoJson;
}

Future loginuser(String company_id, String email, String password) async {
  String token = await getToken();
  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/employee/login';
  final response = await http.post(url,
      headers: {"Accept": "Application/json",
        'Authorization': 'Bearer $token',},
      body: {
        'company_id':company_id,
        'email': email,
        'password': password});

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

class Services {
  static const String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/expense/info/{type}';

  static Future <Expense> getExpense() async {
    String token = await getToken();
      final response = await http.get(Uri.parse('https://sgitjobs.com/EcsAdminPanel/public/api/expense/info/{type}'),
        headers: {"Accept": "Application/json",
        'Authorization': 'Bearer $token',},
      );
      print(response.statusCode);
      if(200 == response.statusCode){
        var result = jsonDecode(response.body);
        return Expense.fromJson(result);
      }else{
        return Expense();
      }

  }
}



class Servicesallstatus {
  static const String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/leaveHistory/allStatus';

  static Future <Allstatus> getStatus() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(url),
      headers: {"Accept": "Application/json",
        'Authorization': 'Bearer $token',},
    );
    print(response.statusCode);
    if(200 == response.statusCode){
      var result = jsonDecode(response.body);
      return Allstatus.fromJson(result);
    }else{
      return Allstatus();
    }

  }
}


Future editdata(String id) async {
  try{
    String token = await getToken();
    String url = "https://sgitjobs.com/EcsAdminPanel/public/api/edit/expense/$id";
    var headers = { HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    final response = await http.get(url,
        headers: headers,
    );
    var data=json.decode(response.body);
    print(response.statusCode);
    print(response.body);
    return data;
  }catch(er){

  }
}



Future updateexpense(String id, String claims,
    String amount,
    String selectdate,
    ) async {
  String token = await getToken();

  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/update/expense/$id';
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var body = jsonEncode({
    "category_id":claims,
    "amount": amount,
    "date":selectdate,

  });

  final response = await http.post(url,
      headers: headers,
      body: body
  );
  print(response.statusCode);
  var convertedDatatoJson = jsonDecode(response.body);
  print(convertedDatatoJson);
  return convertedDatatoJson;
}




Future<History> deleteexpense(String id) async {
  String token = await getToken();
  String url = 'https://sgitjobs.com/EcsAdminPanel/public/api/cancel/expense/$id';
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  final response = await http.post(url,
    headers: headers,
  );
  var data=json.decode(response.body);
  print(response.statusCode);
  print(response.body);
  print(response);
  return History();
}

Future<ApplyLeave> deleteleave(String id) async {
  String token = await getToken();
  String url = "https://sgitjobs.com/EcsAdminPanel/public/api/leave/${id}/delete";
  var headers = { HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  final response = await http.post(url,
    headers: headers,
  );
  var data=json.decode(response.body);
  print(response.statusCode);
  print(response.body);
  print(response);
  return ApplyLeave();
}

