import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_medicine_details.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';


class UserMedicineScreen extends StatefulWidget {
  const UserMedicineScreen({Key? key}) : super(key: key);

  @override
  State<UserMedicineScreen> createState() => _UserMedicineScreenState();
}

class _UserMedicineScreenState extends State<UserMedicineScreen> {
  final _searchController = TextEditingController();


  

  Future<void> _fetchMedicineData() async {
    final url = Uri.parse('$baseUrl/api/view-med');
    final response = await http.get(url);

   try{

     if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      medicineList = jsonData['data'];
      _filteredMedicineList = medicineList;
      setState(() {
        
      });
      
    } else {

      customSnackBar(context: context, messsage: 'Somthing went wrong');
      
    }

   }catch(e){
    customSnackBar(context: context, messsage: 'Somthing went wrong');

   }
  }


  // Inside _UserMedicineScreenState class
List<dynamic> _filteredMedicineList = [];
List<dynamic> medicineList = [];

void _filterMedicineList(String query) {
  setState(() {
    _filteredMedicineList = medicineList.where((medicine) {
      final medicineName = medicine['medicine'].toString().toLowerCase();
      return medicineName.contains(query.toLowerCase());
    }).toList();
  });
}

@override
  void initState() {

     _fetchMedicineData();
    
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    body: medicineList.isEmpty ? indicator  :Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 55,
          child: TextField(
            onChanged: _filterMedicineList,
            decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                gapPadding: 0,
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: .55,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            children: List.generate(
              _filteredMedicineList.length,
              (index) => GestureDetector(
                onTap: () {},
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
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomButton(
                                text: 'view more',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserMedicineDetails(
                                              medicineDetails:
                                                  _filteredMedicineList[index]),
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
        ),
      ],
    ),
  );
}




}



