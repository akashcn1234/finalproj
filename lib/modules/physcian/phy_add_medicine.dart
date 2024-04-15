import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class PhyAddMedicineScreen extends StatefulWidget {
  PhyAddMedicineScreen({super.key});

  @override
  State<PhyAddMedicineScreen> createState() => _PhyAddMedicineScreenState();
}

class _PhyAddMedicineScreenState extends State<PhyAddMedicineScreen> {
  final _addMedicineFormKey = GlobalKey<FormState>();

  Map<String, String> medicineStock = {};

  bool _loading = false;

  File? image;

  void _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: KButtonColor,
        title: const Text(
          'Add Medicine',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? indicator
          : Form(
              key: _addMedicineFormKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,




                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        image != null
                            ? Container(
                                child: Column(
                                children: [
                                  Image.file(
                                    image!,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  CustomButton(
                                    text: 'change',
                                    onPressed: () {
                                      showpopUp(context);
                                    },
                                  )
                                ],
                              ))
                            : Row(
                                children: [
                                  const Text(
                                    'Select image',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const Spacer(),
                                  CustomButton(
                                      text: 'select',
                                      onPressed: () {
                                        showpopUp(context);
                                      })
                                ],
                              ),
                        sizedBox,
                        const Text(
                          'Medicine name',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          hintText: 'Enter name',
                          borderColor: Colors.grey.shade300,

                          validator: (value) {
                            return value!.isEmpty ? 'Enter the name' : null;
                          },
                          onSaved: (value) {
                            medicineStock['medicine'] = value!;
                          },
                        ),
                        sizedBox,
                        const Text(
                          'Composition',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          hintText: 'Enter composition',
                          borderColor: Colors.grey.shade300,
                          validator: (value) {
                            return value!.isEmpty ? 'Enter the quantity' : null;
                          },
                          onSaved: (value) {
                            medicineStock['composition'] = value!;
                          },
                        ),
                        sizedBox,
                        const Text(
                          'Brand',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          hintText: 'Enter brand',
                          borderColor: Colors.grey.shade300,
                          validator: (value) {
                            return value!.isEmpty ? 'Enter the brand' : null;
                          },
                          onSaved: (value) {
                            medicineStock['brand'] = value!;
                          },
                        ),
                        const Text(
                          'Strength',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          hintText: 'Enter strength',
                          borderColor: Colors.grey.shade300,
                          validator: (value) {
                            return value!.isEmpty ? 'Enter the form' : null;
                          },
                          onSaved: (value) {
                            medicineStock['strength'] = value!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Purpose',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormTextField(
                          hintText: 'Enter purpose',
                          borderColor: Colors.grey.shade300,
                          validator: (value) {
                            return value!.isEmpty ? 'Enter the purpose' : null;
                          },
                          onSaved: (value) {
                            medicineStock['purpose'] = value!;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        CustomFormTextField(
                          hintText: 'Enter description',
                          borderColor: Colors.grey.shade300,
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter the description'
                                : null;
                          },
                          onSaved: (value) {
                            medicineStock['description'] = value!;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomButton(
                              text: 'Add',
                              onPressed: () {
                                _addMedicine(context);
                              },
                            ),
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

  Future<dynamic> showpopUp(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _addMedicine(BuildContext context) async {
    bool validate = _addMedicineFormKey.currentState?.validate() ?? false;

    if (validate) {
      _addMedicineFormKey.currentState!.save();

      medicineStock['price'] = '0';
      medicineStock['quantity'] = '0';

      await addMedicineDB(medicineStock, image!.path);

      _addMedicineFormKey.currentState!.reset();

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Transaction Completed Successfully!',
      );
    }
  }

  Future<void> addMedicineDB(Map<String, String> data, String filepath) async {
    const url = '$baseUrl/api/physician/add-med';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields.addAll(data);

      setState(() {
        _loading = true;
      });

      var image = await http.MultipartFile.fromPath('image', filepath);
      request.files.add(image);

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = true;
      });
    }
  }
}
