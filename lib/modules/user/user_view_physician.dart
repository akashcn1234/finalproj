import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class UserPhysicianScreen extends StatefulWidget {
  const UserPhysicianScreen({super.key});

  @override
  State<UserPhysicianScreen> createState() => _UserPhysicianScreenState();
}

class _UserPhysicianScreenState extends State<UserPhysicianScreen> {
  final _searchController = TextEditingController();

  final _physicianList = [
    'https://www.stockvault.net/data/2015/09/01/177580/preview16.jpg',
    'https://www.stockvault.net/data/2015/09/01/177580/preview16.jpg',
  ];

  Future<List<dynamic>> _fetchphy() async {
    final url = Uri.parse('$baseUrl/api/view-physicians');
    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final List<dynamic> data = jsonData['data'];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Our Physcians',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-photo/flat-lay-medical-elements-arrangement-with-copy-space_23-2148502906.jpg?w=1380&t=st=1713245602~exp=1713246202~hmac=cd06fe1af92ae2394f1beb090b082b62660bfbce768f5f5532adf595d9509cb5'),fit: BoxFit.fill)
        ),
        child: FutureBuilder(
          future: _fetchphy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> data = snapshot.data ?? [];
      
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        childAspectRatio: .55,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        children: List.generate(
                          data.length,
                          (index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    _physicianList[0],
                                    fit: BoxFit.fill,
                                    height: 120,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey.shade200)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]['name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data[index]['phone'],
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
