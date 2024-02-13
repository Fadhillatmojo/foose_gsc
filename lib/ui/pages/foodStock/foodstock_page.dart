import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:foose_gsc/ui/widgets/widgets.dart';

class FoodStockPage extends StatefulWidget {
  const FoodStockPage({super.key});

  @override
  State<FoodStockPage> createState() => _FoodStockPageState();
}

class _FoodStockPageState extends State<FoodStockPage> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    _stream = FirebaseFirestore.instance
        .collection('foodstocks')
        .where('uid', isEqualTo: currentUserUid)
        .snapshots();
  }

  List<Widget> groupFoodStocksByName(List<DocumentSnapshot> foodStocks) {
    // fungsi dibawah ini, adalah untuk gruping foodstocks berdasarkan elemen di dalem foodstock (yakni nama yg udah di lowercase)
    var groupedFoodStocks = groupBy(
        foodStocks, (foodStock) => (foodStock['name'] as String).toLowerCase());
    List<Widget> foodStockWidgets = [];

    groupedFoodStocks.forEach((name, stocks) {
      // print('Name: $name');
      List<Map<String, dynamic>> stockDataList = [];
      for (var stock in stocks) {
        var stockData = stock.data() as Map<String, dynamic>;
        stockDataList.add(stockData);
      }

      // print('Stocks: $stockDataList');
      // print('tipe data stocks: ${stockDataList.runtimeType}');

      var totalQuantity = calculateTotalQuantity(stocks);
      // var expirationDuration = stocks[0]['expirationDuration'];
      // var purchaseDate = stocks[0]['purchaseDate'];
      // var purchaseDateTime = (purchaseDate as Timestamp).toDate();
      // var createdAt = DateFormat('dd MMMM yyyy HH:mm').format(purchaseDateTime);

      var foodStockWidget = FoodStockWidget(
        name,
        totalQuantity.toString(),
        // expirationDuration.toString(),
        // createdAt,
        stockDataList,
      );
      foodStockWidgets.add(foodStockWidget);
    });

    return foodStockWidgets;
  }

  int calculateTotalQuantity(List<DocumentSnapshot> stocks) {
    return stocks.fold<int>(
        0, (int sum, DocumentSnapshot stock) => sum + stock['quantity'] as int);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Food Stocks',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Manage Your Food Stocks Here',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      );
                    }

                    var foodStocks = snapshot.data!.docs;
                    // Group widget by nama makanan
                    var groupedFoodStocks = groupFoodStocksByName(foodStocks);

                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: groupedFoodStocks,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
