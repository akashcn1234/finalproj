import 'dart:convert';

import 'package:finalproj/modules/staff/staff_order_details.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';


class StaffViewOrderScreen extends StatefulWidget {
  const StaffViewOrderScreen({super.key});

  @override
  State<StaffViewOrderScreen> createState() => _StaffViewOrderScreenState();
}

class _StaffViewOrderScreenState extends State<StaffViewOrderScreen> {
  final orderList = [
    'https://images.pexels.com/photos/159211/headache-pain-pills-medication-159211.jpeg',
    'https://images.pexels.com/photos/593451/pexels-photo-593451.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1424538/pexels-photo-1424538.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

 Future<List<dynamic>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/api/staff/view-orders'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData['Data'];
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Orders'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: KButtonColor,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orderList = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                
                print('hdddddddddddddddd');

                print(order);
                
                final medicineData = order['medicine_data'];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                          child: Image(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(medicineData['image']),
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
                              medicineData['medicine'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'quantity: ${order['unit']}',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            CustomButton(text: 'View more', onPressed: () async{
                            final ref =  await   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StaffMedicineDetails(
                                      image: medicineData['image'],
                                      details: medicineData,
                                      orderId : order['_id']
                                      // Pass other details as needed
                                    ),
                                  ),
                                );

                              if(ref){
                                setState(() {
                                  
                                });
                              }
                            },)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
