import 'package:flutter/material.dart';

class PhySearchScreen extends StatefulWidget {
  const PhySearchScreen({super.key});

  @override
  State<PhySearchScreen> createState() => _PhySearchScreenState();
}

class _PhySearchScreenState extends State<PhySearchScreen> {


  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Search medicine'),
      ),

      body: Column(
        children: [


          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 55,
            child: TextField(
              enabled: true,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
         


        ],
      ),
    );
  }
}