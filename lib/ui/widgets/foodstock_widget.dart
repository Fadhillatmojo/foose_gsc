import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:intl/intl.dart';

class FoodStockWidget extends StatelessWidget {
  final String name;
  final String totalQuantity;
  // final String expirationDuration;
  // final String purchaseDate;
  final List<Map<String, dynamic>> stocks;

  const FoodStockWidget(this.name, this.totalQuantity, this.stocks, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController for each item
    List<TextEditingController> textControllers = [];
    for (var stock in stocks) {
      textControllers.add(TextEditingController(
        text: stock['quantity'].toString(),
      ));
    }

    // Customize the UI for displaying each article
    return GestureDetector(
      onTap: () {
        // function buat munculin bottom pop up detail
        _showFoodStockDetails(context);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // setiap row nya isinya adalah icon trash, nama food, total totalQuantity
          children: [
            Text(
              name.capitalizeFirstLetter(),
              maxLines: 1, // Set the maximum number of lines
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'X $totalQuantity',
              maxLines: 1, // Set the maximum number of lines
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFoodStockDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: [
                const Text(
                  'Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 25),
                for (var stock in stocks)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name.capitalizeFirstLetter(),
                            maxLines: 2, // Set the maximum number of lines
                            overflow: TextOverflow
                                .ellipsis, // Show ellipsis when text overflows
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            _getFormattedDate(stock['purchaseDate']),
                            maxLines: 1, // Set the maximum number of lines
                            style: const TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline_rounded),
                            onPressed: () {
                              // kurangkan quantity di sini
                            },
                          ),
                          Text(
                            '${stock['quantity']}',
                            maxLines: 1, // Set the maximum number of lines
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.remove_circle_outline_rounded),
                            onPressed: () {
                              // kurangkan quantity di sini
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFormattedDate(Timestamp purchaseDate) {
    var purchaseDateTime = purchaseDate.toDate();
    return DateFormat('dd/MM/yyyy').format(purchaseDateTime);
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : '';
  }
}
