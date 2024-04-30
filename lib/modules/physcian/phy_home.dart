import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../auth/login.dart';
import 'phy_add_medicine.dart';
import 'phy_medicine_details.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class PhyHomeViewScreen extends StatefulWidget {
  const PhyHomeViewScreen({super.key});

  @override
  State<PhyHomeViewScreen> createState() => _PhyHomeViewScreenState();
}

class _PhyHomeViewScreenState extends State<PhyHomeViewScreen> {
  final _medicineList = [
    'https://images.pexels.com/photos/159211/headache-pain-pills-medication-159211.jpeg',
    'https://images.pexels.com/photos/593451/pexels-photo-593451.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1424538/pexels-photo-1424538.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  Future<List<dynamic>> _fetchMedicineData() async {
    final url = Uri.parse('$baseUrl/api/view-med');
    final response = await http.get(url);


    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');



    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData['data'].last);

      final List<dynamic> data = jsonData['data'];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {

    
    return  Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          
          iconTheme: const IconThemeData(color: Colors.black),
          leadingWidth: 200,
          // leading: const Row(
          //   children: [
          //     SizedBox(width: 10,),
          //     Icon(Icons.person_pin,size: 40,color: Colors.white,),
          //     Text('name',style: TextStyle(color: Colors.white,fontSize: 18),)
          //   ],
          // ),
          
          actions: [
            const Text('Logout',style: TextStyle(color: Colors.red,fontSize: 18),),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
            ),
          ]),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButton(
          text: 'Add new medicine',
          onPressed: () async {
            bool update =  await   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhyAddMedicineScreen(),
              ),
            );

            if(update){
              setState(() {

              });
            }
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
        
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('https://images.pexels.com/photos/4386464/pexels-photo-4386464.jpeg?auto=compress&cs=tinysrgb&w=600'))
        ),
        
        child: Column(
          children: [
            SizedBox(height: 30,),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _fetchMedicineData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<dynamic> medicineList = snapshot.data ?? [];
      

      
                    return medicineList.isEmpty ?  const Center(child: Text('No Medicine'),) :Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        childAspectRatio: .55,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        children: List.generate(
                          medicineList.length,
                          (index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      medicineList[index]['image'],
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          medicineList[index]['medicine'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CustomButton(
                                            text: 'view more',
                                            onPressed: ()  async{
                                             Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhyMedicineDetailsScreen(
                                                          medicineDetails:
                                                              medicineList[
                                                                  index]),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            
            
            
            
            )
          ],
        ),
      ),
    );
  }
}
