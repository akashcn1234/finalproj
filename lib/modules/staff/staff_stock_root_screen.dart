import 'package:finalproj/modules/staff/staff_stock_manage_medicine_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';



// ignore: must_be_immutable
class AddMedicineStockRootScreen extends StatelessWidget {
  AddMedicineStockRootScreen({super.key});

  final _addMedicineFormKey = GlobalKey<FormState>();

  Map<String, dynamic> _medicineStock = {};

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    const sizedBox = const SizedBox(
      height: 20,
    );
    return Scaffold(
      
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: KButtonColor,
        title: const Text(
          'Stock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: StaffStockManageMedicineScreen(

      )
    
    );
  }
  
}
