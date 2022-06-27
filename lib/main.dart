// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Future sendEmail(
      {String? email, String? name, String? mess, String? sub}) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    const serviceId = 'service_z592z45';
    const templateId = 'template_iljf0fg';
    const userId = 'cmGhXr7ykbNgFQML8';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'name': name,
          'message': mess,
          'to_email': email,
          'subjetc': sub,
          'reply_to': "NO REPLY",
        }
      }),
    );
    if (response.statusCode == 200) {
      print('Sucess ${response.statusCode}');
    } else {
      print('Error ${response.statusCode}');
    }
    // return response.statusCode;
  }

  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController messC = TextEditingController();
  TextEditingController subC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          TextField(
            controller: nameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: messC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Message',
            ),
          ),
          TextField(
            controller: subC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Subject',
            ),
          ),
          TextField(
            controller: emailC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                sendEmail(
                  email: emailC.text,
                  mess: messC.text,
                  sub: subC.text,
                  name: nameC.text,
                );
              },
              child: Text('Send Mail'))
        ],
      ),
    );
  }
}
