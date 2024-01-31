import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
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
                  'Manage Your Food Stock here',
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
                      List<Widget> foodStockWidgets = [];

                      for (var foodStock in foodStocks) {
                        var name = foodStock['name'];
                        var quantity = foodStock['quantity'].toString();
                        var expirationDuration =
                            foodStock['expirationDuration'];
                        var purchaseDate = foodStock['purchaseDate'];

                        // Konversi Timestamp ke DateTime dan kemudian ke dalam String dengan format yang diinginkan
                        var purchaseDateTime =
                            (purchaseDate as Timestamp).toDate();
                        var createdAt = DateFormat('dd MMMM yyyy HH:mm')
                            .format(purchaseDateTime);

                        // Assuming you have a separate widget for displaying foodStocks
                        var foodStockWidget = FoodStockWidget(
                            name, quantity, expirationDuration, createdAt);
                        foodStockWidgets.add(foodStockWidget);
                      }

                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: foodStockWidgets,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
