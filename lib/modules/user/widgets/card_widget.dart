import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class CardWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final double? padding;

  final Widget? child;

  final Color? iconColor;

  const CardWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("asset/medicine.png"),
          fit: BoxFit.cover),
        ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

        child ?? Icon(
          iconData,
          size: 40.0,
          color: iconColor ?? Colors.white,
        ),
        const SizedBox(height: 15.0),
        Text(

          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),

      ],)),
      // child: Container(
      //   child: Card(
      //     elevation: 2.0,
      //     color: Colors.green,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //     ),
      //     child: Padding(
      //       padding: EdgeInsets.all(padding ?? 16.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           child ?? Icon(
      //             iconData,
      //             size: 40.0,
      //             color: iconColor ?? Colors.white,
      //           ),
      //           const SizedBox(height: 15.0),
      //           Text(
      //
      //             title,
      //             textAlign: TextAlign.center,
      //             style: const TextStyle(
      //                 fontSize: 15.0,
      //                 fontWeight: FontWeight.w400,
      //                 color: Colors.white),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
