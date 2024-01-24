import 'package:flutter/material.dart';

class FoodStockPage extends StatefulWidget {
  const FoodStockPage({super.key});

  @override
  State<FoodStockPage> createState() => _FoodStockPageState();
}

class _FoodStockPageState extends State<FoodStockPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Foodstock'));
  }
}
