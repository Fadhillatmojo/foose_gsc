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
  Color _containerColor = Colors.transparent;

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
    // generate recipe button material
    final generateRecipeButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(30),
      color: AppColors.accentColor,
      child: MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        minWidth: null,
        splashColor: AppColors.darkColor,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Atur radius sudut di sini
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Generate Recipe',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_circle_right_sharp,
              color: Colors.white,
            )
          ],
        ),
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(children: [
                GestureDetector(
                  onTap: () {
                    // Ubah warna kontainer menjadi abu-abu sejenak ketika diklik
                    setState(() {
                      _containerColor = AppColors
                          .microInteractionGreyColor; // Warna abu-abu dengan opasitas 0.5
                    });

                    // Kembalikan warna kontainer ke semula setelah beberapa waktu
                    Future.delayed(const Duration(milliseconds: 200), () {
                      setState(() {
                        _containerColor =
                            Colors.transparent; // Kembalikan ke transparan
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                      color: _containerColor,
                    ),
                    child: const Icon(
                      Icons.more_vert_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
              Column(
                children: [
                  const Text(
                    'Food Stocks',
                    // textAlign: TextAlign.center,
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
                        var groupedFoodStocks =
                            groupFoodStocksByName(foodStocks);

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
              const SizedBox(
                height: 30,
              ),
              generateRecipeButton,
            ],
          ),
        ),
      ),
    );
  }
}
