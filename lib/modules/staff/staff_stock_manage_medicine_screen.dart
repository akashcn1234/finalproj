import 'dart:convert';

import 'package:finalproj/modules/staff/stock_medicine_details.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class StaffStockManageMedicineScreen extends StatefulWidget {
  const StaffStockManageMedicineScreen({super.key});

  @override
  State<StaffStockManageMedicineScreen> createState() =>
      _StaffStockManageMedicineScreenState();
}

class _StaffStockManageMedicineScreenState
    extends State<StaffStockManageMedicineScreen> {
  final _searchController = TextEditingController();

  final _medicineList = [
    'https://images.pexels.com/photos/159211/headache-pain-pills-medication-159211.jpeg',
    'https://images.pexels.com/photos/593451/pexels-photo-593451.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1424538/pexels-photo-1424538.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  List<dynamic> _filteredMedicineList = [];
  List<dynamic> data = [];

  Future _fetchMedicineData() async  {
    final url = Uri.parse('$baseUrl/api/view-med');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

       data = jsonData['data'];

      _filteredMedicineList = data;

      setState(() {

      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Faild')));
    }
  }




  void _searchMedicine(String query) {
    _filteredMedicineList = data.where((medicine) {
      final String name = medicine['medicine'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {

    });
  }

  @override
  void initState() {
    _fetchMedicineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 55,
          child: TextField(
            enabled: true,
            controller: _searchController,
            onChanged: (value) {
              _searchMedicine(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                gapPadding: 0,
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: data.isEmpty ?  Center(child: CircularProgressIndicator(),)  :  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              childAspectRatio: .5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              children: List.generate(
                  _filteredMedicineList.length,
                    (index) => GestureDetector(
                  onTap: () async {
                    bool isRef = await   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffStockMedicineDetails(
                          data: _filteredMedicineList[index],
                        ),
                      ),
                    );
                    print('hhhhhh');
                    print(isRef);

                    if(isRef){
                      setState(() {

                      });
                    }
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _filteredMedicineList[index]['image'],
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredMedicineList[index]['medicine'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(
                                  text: 'view more',
                                  color: KButtonColor,
                                  onPressed: () async {
                                   bool ref = await  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StaffStockMedicineDetails(
                                              data: _filteredMedicineList[index],
                                            ),
                                      ),
                                    );
                                   print('ffffffff');
                                   print(ref);

                                   if(ref){

                                     setState(() {

                                       _fetchMedicineData();

                                     });
                                   }


                                  },
                                ),
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
          )

        ),
     
     
     
     
      ],
    );
  }

  void _deleteStock() {
    print('delete');
  }
}
