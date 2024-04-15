import 'package:flutter/material.dart';

import '../auth/login.dart';
import 'user_complaint.dart';
import 'user_medicine_screen.dart';
import 'user_view_oreder_screen.dart';
import 'user_view_physician.dart';
import 'user_view_stock_screen.dart';
import 'widgets/card_widget.dart';
import '../../utils/constants.dart';


class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: KButtonColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('https://images.pexels.com/photos/208512/pexels-photo-208512.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'))
        ),
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            CardWidget(
              iconData: Icons.inventory,
              title: 'View Stock',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserViewStockSceeen(),
                    ));
              },
            ),
            CardWidget(
              iconData: Icons.vaccines,
              title: 'Medicine Details',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserMedicineScreen();
                }));
              },
            ),
            CardWidget(
              iconData: Icons.book,
              title: 'View Order',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserViewOrderScreen(),
                  ),
                );
              },
            ),
            CardWidget(
              iconData: Icons.medication,
              title: 'View physician',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserPhysicianScreen(),
                  ),
                );
              },
            ),
            CardWidget(
              iconData: Icons.add,
              title: 'Add Complaint',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserComplaintScreen(),
                  ),
                );
              },
            ),
            CardWidget(
                iconData: Icons.logout,
                title: 'Logout',
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                }),
          ],
        ),
      
      
      
      
      ),
    );
  }
}
