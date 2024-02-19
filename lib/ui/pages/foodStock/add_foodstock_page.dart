import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class AddFoodStock extends StatefulWidget {
  const AddFoodStock({super.key});

  @override
  State<AddFoodStock> createState() => _AddFoodStockState();
}

class _AddFoodStockState extends State<AddFoodStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Text('Add page food stocks'),
            ]),
          ),
        ),
      ),
    );
  }
}
