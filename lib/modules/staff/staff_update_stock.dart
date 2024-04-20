// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finalproj/modules/staff/staff_root_screen.dart';
import 'package:flutter/material.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class UpdateMedicineStaff extends StatefulWidget {
  UpdateMedicineStaff(
      {Key? key, required this.stock, required this.medicineStock})
      : super(key: key);

  final String stock;

  Map<String, dynamic> medicineStock;

  @override
  State<UpdateMedicineStaff> createState() => _UpdateMedicineStaffState();
}

class _UpdateMedicineStaffState extends State<UpdateMedicineStaff> {
  final _editMedicineFormKey = GlobalKey<FormState>();

  bool _loading = false;

  Future<void> updateMedicineForStaff(
      String id, Map<String, dynamic> data) async {





    _editMedicineFormKey.currentState!.save();

    

   
    final url = Uri.parse('$baseUrl/api/staff/update-med/$id');


    
  widget.medicineStock.remove('_id');
  widget.medicineStock.remove('__v');
  widget.medicineStock.remove('image');
  widget.medicineStock.remove('stock');

 

    try {
      setState(() {
        _loading = true;
      });

     
      final response = await http.put(
        url,
        body: widget.medicineStock,
      );

     

      
    

      

      if (response.statusCode == 200) {
        if (context.mounted) {
          

         setState(() {
            _loading = false;
         });

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StaffRootScreen(),), (route) => false);
        }
      } else {
        setState(() {
          _loading = false;
        });

        if (context.mounted) {
          customSnackBar(context: context, messsage: 'Faild');
        }
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });

      print(e);

      if (context.mounted) {
        customSnackBar(context: context, messsage: 'Faild');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = const SizedBox(
      height: 20,
    );
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          text: 'Update',
          onPressed: () {
            updateMedicineForStaff(
                widget.medicineStock['_id'], widget.medicineStock);
          },
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: KButtonColor,
        title: const Text(
          'Update Stock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? indicator
          : Form(
              key: _editMedicineFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox,
                      const Text(
                        'Medicine name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        hintText: 'Enter name',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['medicine'],
                        validator: (value) {
                          return value!.isEmpty ? 'Enter the name' : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['medicine'] = value;
                        },
                      ),
                      sizedBox,
                      const Text(
                        'Composition',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        hintText: 'Enter composition',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['composition'],
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Enter the composition'
                              : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['composition'] = value;
                        },
                      ),
                      sizedBox,
                      const Text(
                        'Brand',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        hintText: 'Enter brand',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['brand'],
                        validator: (value) {
                          return value!.isEmpty ? 'Enter the brand' : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['brand'] = value;
                        },
                      ),
                      sizedBox,
                      const Text(
                        'Medicine price',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        hintText: 'Enter price',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['price'].toString(),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter the price' : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['price'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Medicine Quantity',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        hintText: 'Enter quantity',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['quantity'].toString(),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter the price' : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['quantity'] = value;
                        },
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      CustomFormTextField(
                        hintText: 'Enter Description',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['description'],
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Enter the description'
                              : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['description'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Purpose',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      CustomFormTextField(
                        hintText: 'Enter purpose',
                        borderColor: Colors.grey.shade300,
                        initialValue: widget.medicineStock['purpose'],
                        validator: (value) {
                          return value!.isEmpty ? 'Enter the purpose' : null;
                        },
                        onSaved: (value) {
                          widget.medicineStock['purpose'] = value;
                        },
                      ),

                      SizedBox(height: 50,)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
