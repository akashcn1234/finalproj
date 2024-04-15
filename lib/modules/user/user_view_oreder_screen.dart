import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../db/shared_pref.dart';
import '../../utils/constants.dart';

class UserViewOrderScreen extends StatefulWidget {
  const UserViewOrderScreen({super.key});

  @override
  State<UserViewOrderScreen> createState() => _UserViewOrderScreenState();
}

class _UserViewOrderScreenState extends State<UserViewOrderScreen> {
  final orderList = [
    'https://images.pexels.com/photos/159211/headache-pain-pills-medication-159211.jpeg',
    'https://images.pexels.com/photos/593451/pexels-photo-593451.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1424538/pexels-photo-1424538.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: viewOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> data = snapshot.data ?? [];

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                   Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(20)),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              data[index]['medicine_data']['image']
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['medicine_data']['medicine'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'quantity:${data[index]['unit']}',
                            style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                           Text(
                            '${data[index]['status']}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> viewOrders() async {
    final url =
        Uri.parse('${baseUrl}/api/user/view-order/${DbService.getLoginId()}');

    try {
      final response = await http.get(url);

      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['Data'];

        return data;
      } else {
        throw Exception('Somthing went wrong');
      }
    } catch (error) {
      rethrow;
    }
  }
}
