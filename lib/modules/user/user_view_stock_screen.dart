import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_add_order_screen.dart';
import '../../utils/constants.dart';

class UserViewStockSceeen extends StatefulWidget {
  const UserViewStockSceeen({Key? key}) : super(key: key);

  @override
  State<UserViewStockSceeen> createState() => _UserViewStockSceeenState();
}

class _UserViewStockSceeenState extends State<UserViewStockSceeen> {
  final _searchController = TextEditingController();
  List<dynamic> _medicineList = [];
  List<dynamic> _filteredMedicineList = [];

  bool loading =  false;

  Future<void> _fetchMedicineData() async {

    setState(() {
      loading = true;
    });
    final url = Uri.parse('$baseUrl/api/view-med');
    final response = await http.get(url);



    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];


        setState(() {
          _medicineList = data;
           _filteredMedicineList =  _medicineList;
          loading = false;
        });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

   void _searchMedicine(String query) {
    _filteredMedicineList = _medicineList.where((medicine) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) :  Column(
        children: [
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
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child:  ListView.builder(
                    itemCount: _filteredMedicineList.length,
                    itemBuilder: (context, index) => Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: KButtonColor),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.horizontal(
                                        right: Radius.circular(20)),
                                    child: Image(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                          _filteredMedicineList[index]['image']),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _filteredMedicineList[index]['medicine'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Unit:${_filteredMedicineList[index]['stock']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      _filteredMedicineList[index]['price'].toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserAddOrderScreen(
                                      id: _filteredMedicineList[index]['_id'].toString(),
                                      description: _filteredMedicineList[index]['description'].toString(),
                                      name: _filteredMedicineList[index]['medicine'].toString(),
                                      price: _filteredMedicineList[index]['price'].toString(),
                                      imageUrl: _filteredMedicineList[index]['image'].toString(),
                                      stock: _filteredMedicineList[index]['stock'].toString(),
                                      manuDate: _filteredMedicineList[index]['manu_date'].toString(),
                                      expDate:  _filteredMedicineList[index]['expiry_date'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Order Now >',
                                style: TextStyle(
                                    color: KButtonColor, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )


          ),
        ],
      ),
    );
  }
}
