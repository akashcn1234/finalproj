import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../db/shared_pref.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class UserComplaintScreen extends StatefulWidget {
  UserComplaintScreen({super.key});

  @override
  State<UserComplaintScreen> createState() => _UserComplaintScreenState();
}

class _UserComplaintScreenState extends State<UserComplaintScreen> {
  final _complaint = TextEditingController();

  bool _loading = false;

  Future<void> addComplaint() async {
    try {
      setState(() {
        _loading = true;
      });

      final url = Uri.parse(
          '$baseUrl/api/user/add-complaint/${DbService.getLoginId()}');
      final response = await http.post(
        url,
        body: {
          'complaint': _complaint.text,
          'date' : DateFormat('dd-MM-yyyy').format(DateTime.now())
        },
      );

      print(response.body);



      if (response.statusCode == 201) {
        if (context.mounted) {
          customSnackBar(context: context, messsage: 'Success');

          setState(() {
            _loading = false;
          });
        }
      } else {
        setState(() {
          _loading = false;
        });

        if (context.mounted) {
          customSnackBar(context: context, messsage: 'Something went wrong');
        }
      }
    } catch (e) {
      if (context.mounted) {
        customSnackBar(context: context, messsage: 'Something went wrong');
      }
    }
  }

  Future<dynamic> viewComplaints() async {
    try {
      final url = Uri.parse(
          '$baseUrl/api/user/view-complaint/${DbService.getLoginId()}');
      final response = await http.get(
        url,
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Add complaints'),
              Tab(text: 'View Replay'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _loading
                ? indicator
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Add your complaint',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Add your complaint',
                          controller: _complaint,
                          borderColor: Colors.grey,
                          maxLines: 200,
                          minLine: 6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            text: 'Submit',
                            onPressed: () {
                              addComplaint();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
            FutureBuilder(
              future: viewComplaints(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> complaints = snapshot.data as List<dynamic>;

                  print(complaints);
                  return ListView.builder(
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Alert'),
                                content:
                                complaints[index]['reply'].length != 0 ?  Text(complaints[index]['reply']) :Text('We will reachout you soon') ,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: Icon(Icons.chat),
                        title: Text(complaints[index]['complaint']),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
