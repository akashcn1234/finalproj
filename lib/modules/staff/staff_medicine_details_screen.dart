
import 'package:finalproj/modules/staff/staff_root_screen.dart';
import 'package:finalproj/modules/staff/staff_update_stock.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../utils/constants.dart';
import '../../widgets/column_text.dart';
import '../../widgets/custom_button.dart';

class StaffMedicineDetailsScreen extends StatefulWidget {
  const StaffMedicineDetailsScreen({super.key, required this.image, required this.medicineDetails});

  final String image;
  final Map<String, dynamic> medicineDetails;

  @override
  State<StaffMedicineDetailsScreen> createState() => _StaffMedicineDetailsScreenState();
}

class _StaffMedicineDetailsScreenState extends State<StaffMedicineDetailsScreen> {

  bool _loading = false;



  Future<void> deleteMedicineForStaff(String id) async {

  final url = Uri.parse('$baseUrl/api/staff/delete-med/$id');


  try {
    setState(() {
      _loading = true;
    });
    final response = await http.delete(url);

    if (response.statusCode == 200) {


      if(context.mounted){

        setState(() {
          _loading = false;
        });
        

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StaffRootScreen(),), (route) => false);
      }
      
    } else {
       if(context.mounted){
        setState(() {
          _loading = false;
        });
        customSnackBar(context: context, messsage: 'Faild');
       }
    }
  } catch (e) {
    setState(() {
      _loading = false;
    });
     if(context.mounted){
      customSnackBar(context: context, messsage: 'Faild');
     }
  }
}






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
              text: 'Update medicine',
              onPressed: () async{


                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateMedicineStaff(stock:'10' ,medicineStock: widget.medicineDetails,),));
          
              
                
              },
            ),
          ),
          Expanded(
            child: CustomButton(
              text: 'Delete medicine',
              color: Colors.red,
              onPressed: () {

                deleteMedicineForStaff(widget.medicineDetails['_id']);
          
              
                
              },
            ),
          ),
        ],
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
                      padding: const EdgeInsets.all(10),
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
