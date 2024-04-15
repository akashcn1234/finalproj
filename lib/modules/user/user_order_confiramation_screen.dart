import 'package:flutter/material.dart';

import 'user_root_screen.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';


class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({super.key});

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );
    return Scaffold(
      backgroundColor: KButtonColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('asset/images/Vector.png', width: 132, height: 132),
          sizedBox,
          const Text(
            'Your order has been received',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Order status',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          sizedBox,
          SizedBox(
            width: 200,
            child: CustomButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRootScreen(),
                    ),
                    (route) => false);
              },
              text: 'Home',
              color: Colors.white,
              texColor: KButtonColor,
            ),
          )
        ]),
      ),
    );
  }
}
