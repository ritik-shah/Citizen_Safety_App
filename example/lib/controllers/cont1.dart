import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter_sms_inbox_example/spam.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class SecureZeta extends GetxController {

  var message= [];

 int result = 0;
int index = 0;
 late var msgg ;

  getCategories(  List<SmsMessage> messages,BuildContext context) async {
print(messages.toList()[0].body.toString());

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://ec2-35-153-230-236.compute-1.amazonaws.com');
    List<String> msg=[];
    for(int i=0;i<messages.length;i++)
    msg.add(messages.toList()[i].body.toString());
    var body = {
      "messages":msg
    };

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var x = json.decode(resBody);
       msgg = Spam.fromJson(x) ;
      print(msgg.result![0].message.toString());
    }
    else {
      print(res.reasonPhrase);
    }




print(result);
if(result == 1) {
  showDialog(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title: const Text("Spam"),

          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(14),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
  );

  // print(result[i]);
}
      }

    }


