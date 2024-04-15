import 'package:finalproj/modules/staff/staff_root_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../widgets/column_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'package:http/http.dart'as http;


class StaffStockMedicineDetails extends StatefulWidget {
  const StaffStockMedicineDetails({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<StaffStockMedicineDetails> createState() =>
      _StaffStockMedicineDetailsState();
}

class _StaffStockMedicineDetailsState extends State<StaffStockMedicineDetails> {
  Future<void> updateMedicineStock(String id, String stock) async {
    final url = Uri.parse('$baseUrl/api/staff/update-med-stock/$id');

    setState(() {
      _loading = true;
    });

    final response = await http.put(url, body: {'stock': stock});

      Navigator.pop(context,true);

    if (response.statusCode != 200) {
      throw Exception('Failed to update medicine stock');
    }
  }

  Future<void> deleteMedicine(String id, String stock) async {
    final url = Uri.parse('$baseUrl/api/staff/update-med-stock/$id');

    final response = await http.put(url, body: {'stock': '0'});

    if (response.statusCode != 200) {
      throw Exception('Failed to update medicine stock');
    }
  }

  final stockController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 10,
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Add more stock',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Add'),
                          content: _loading
                              ? indicator
                              : CustomTextField(
                                  controller: stockController,
                                  hintText: 'Enter stock',
                                ),
                          actions: [
                            CustomButton(
                              text: 'Add',
                              onPressed: () async {
                                if (stockController.text.isNotEmpty) {

                                 Navigator.pop(context);


                                  await updateMedicineStock(
                                      widget.data['_id'], stockController.text);
                                  setState(() {
                                    _loading = false;
                                  });
                                } else {
                                  customSnackBar(
                                      context: context,
                                      messsage: 'Fill the field');
                                }
                              },
                            )
                          ],
                        ));
              },
            ),
          ),
          Expanded(
            child: CustomButton(
              text: 'Delete stock',
              color: Colors.red,
              onPressed: () async {
                setState(() {
                  _loading = true;
                });

                await deleteMedicine(widget.data['_id'], '0');

                Navigator.pop(context,true);

                _loading = false;
              },
            ),
          ),
        ],
      ),
      body:_loading ? indicator : Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.data['image'],
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ColumnText(
                                  text1: 'Name',
                                  text2: widget.data['medicine'],
                                ),
                                sizedBox,
                                ColumnText(
                                    text1: 'Price:',
                                    text2: widget.data['price'].toString()),
                                sizedBox,
                                ColumnText(
                                    text1: 'stock:',
                                    text2: widget.data['stock'].toString()),
                                sizedBox,
                                ColumnText(
                                    text1: 'Description',
                                    text2: widget.data['description']),

                                SizedBox(height: 100,)    
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
