import 'package:flutter/material.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class AddMedicineStockScreen extends StatelessWidget {
  AddMedicineStockScreen({super.key});

  final _addMedicineFormKey = GlobalKey<FormState>();

  Map<String, dynamic> _medicineStock = {};

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          text: 'Add',
          onPressed: () {
            _addMedicineStock(context);
          },
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: KButtonColor,
        title: const Text(
          'Add Stock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _addMedicineFormKey,
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
                  validator: (value) {
                    return value!.isEmpty ? 'Enter the name' : null;
                  },
                  onSaved: (value) {
                    _medicineStock['name'] = value;
                  },
                ),
                sizedBox,
                const Text(
                  'Quantity',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  hintText: 'Enter quantitiy',
                  borderColor: Colors.grey.shade300,
                  validator: (value) {
                    return value!.isEmpty ? 'Enter the quantity' : null;
                  },
                  onSaved: (value) {
                    _medicineStock['qty'] = value;
                  },
                ),
                sizedBox,
                const Text(
                  'Unit',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  hintText: 'Enter unit',
                  borderColor: Colors.grey.shade300,
                  validator: (value) {
                    return value!.isEmpty ? 'Enter the unit' : null;
                  },
                  onSaved: (value) {
                    _medicineStock['unit'] = value;
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
                  validator: (value) {
                    return value!.isEmpty ? 'Enter the price' : null;
                  },
                  onSaved: (value) {
                    _medicineStock['price'] = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addMedicineStock(BuildContext context) {
    bool validate = _addMedicineFormKey.currentState?.validate() ?? false;

    if (validate) {
      _addMedicineFormKey.currentState!.save();

      _addMedicineFormKey.currentState!.reset();

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Transaction Completed Successfully!',
      );
    }
  }
}
