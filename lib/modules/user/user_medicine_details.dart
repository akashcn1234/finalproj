import 'package:flutter/material.dart';

import 'user_add_order_screen.dart';
import '../../widgets/column_text.dart';
import '../../widgets/custom_button.dart';


class UserMedicineDetails extends StatefulWidget {
  const UserMedicineDetails({super.key, required this.medicineDetails});

  final Map<String, dynamic> medicineDetails;

  @override
  State<UserMedicineDetails> createState() => _UserMedicineDetailsState();
}

class _UserMedicineDetailsState extends State<UserMedicineDetails> {
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
      body: Padding(
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
                          widget.medicineDetails['image'],
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ColumnText(
                                  text1: 'Description',
                                  text2: widget.medicineDetails['description']
                                ),
                                sizedBox,
                                ColumnText(
                                    text1: 'Purpose',
                                    text2: widget.medicineDetails['purpose']),
                                sizedBox,
                                ColumnText(
                                    text1: 'Composition',
                                    text2: widget.medicineDetails['composition']
                                        
                                        ),
                                sizedBox,
                                ColumnText(
                                    text1: 'Strength',
                                    text2:widget.medicineDetails['strength']
                                    ),
                                ColumnText(
                                    text1: 'Brand',
                                    text2: widget.medicineDetails['brand']
                                    ),
                                ColumnText(
                                    text1: 'Quantity',
                                    text2: widget.medicineDetails['quantity'],
                                        ),

                              ColumnText(
                                    text1: 'Price',
                                    text2: widget.medicineDetails['price'].toString(),
                                        ),
                              ],
                            ),
                          ),
                        ))
                 
                 
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Order now',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserAddOrderScreen(
                        id: widget.medicineDetails['_id'],
                        description: widget.medicineDetails['description'],
                        name: widget.medicineDetails['medicine'],
                        price: widget.medicineDetails['price'].toString(),
                        stock: '0',
                        imageUrl:widget.medicineDetails['image']
                      

                      
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  
  
  
  }
}
