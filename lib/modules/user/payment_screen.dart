import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import '../../widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
   PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

   DateTime? manuDate;

   final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Card Details',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                      validator: (value) => value!.isEmpty ? 'Fill the value' : null,
                      decoration: InputDecoration(
                          hintText: 'Card number',
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          prefixIcon: Icon(Icons.add_card),
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w400),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.red))),
                    ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async{

                        manuDate = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                          borderRadius: 16,
                        );
                        if (manuDate != null) {
                          controller.text = '${manuDate!.day}/${manuDate!.month}/${manuDate!.year}';
                          setState(() {});
                        }

                      },
                      child: TextField(
                        enabled: false,
                       controller   : controller,


                        decoration: InputDecoration(

                            hintText: 'Expair Date',
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            border: outlineInputBorder,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      validator: (value) => value!.isEmpty ? 'Fill the value' : null,
                      decoration: InputDecoration(
                          hintText: 'CVV',
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w400),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.red))),
                    ),
                  ),
                ],
              ),
              Expanded(child: Image.asset('asset/images/car.png',fit: BoxFit.fill,)),
              const SizedBox(height: 20.0),
              CustomButton(text: 'Add', onPressed: () {

                if(_formKey.currentState!.validate()){

                  Navigator.pop(context ,true);

                }

              },)
            ],
          ),
        ),
      ),
    );
  }
}
