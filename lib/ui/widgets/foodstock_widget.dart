import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:intl/intl.dart';

class FoodStockWidget extends StatefulWidget {
  final String name;
  final String totalQuantity;
  // final String expirationDuration;
  // final String purchaseDate;
  final List<Map<String, dynamic>> stocks;

  const FoodStockWidget(this.name, this.totalQuantity, this.stocks, {Key? key})
      : super(key: key);

  @override
  State<FoodStockWidget> createState() => _FoodStockWidgetState();
}

class _FoodStockWidgetState extends State<FoodStockWidget> {
  Color _containerColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController for each item
    List<TextEditingController> textControllers = [];
    for (var stock in widget.stocks) {
      textControllers.add(TextEditingController(
        text: stock['quantity'].toString(),
      ));
    }

    // Customize the UI for displaying each article
    return GestureDetector(
      onTap: () {
        // function buat munculin bottom pop up detail
        _showFoodStockDetails(context);

        // Ubah warna kontainer menjadi abu-abu sejenak ketika diklik
        setState(() {
          _containerColor = AppColors
              .microInteractionGreyColor; // Warna abu-abu dengan opasitas 0.5
        });

        // Kembalikan warna kontainer ke semula setelah beberapa waktu
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _containerColor = Colors.transparent; // Kembalikan ke transparan
          });
        });
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        color: _containerColor, // Warna kontainer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // setiap row nya isinya adalah icon trash, nama food, total totalQuantity
              children: [
                Text(
                  widget.name.capitalizeFirstLetter(),
                  maxLines: 1, // Set the maximum number of lines
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'X ${widget.totalQuantity}',
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
                for (var stock in widget.stocks)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name.capitalizeFirstLetter(),
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
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: AppColors.darkIconColor,
                            ),
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
                            icon: const Icon(
                              Icons.remove_circle_outline_rounded,
                              color: AppColors.darkIconColor,
                            ),
                            onPressed: () {
                              // kurangkan quantity di sini
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // Cancel button material
                  MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    minWidth: null,
                    splashColor: AppColors.microInteractionGreyColor,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: AppColors.accentColor)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Discard',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.accentColor, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.cancel_outlined,
                          color: AppColors.accentColor,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Save button material
                  MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    minWidth: null,
                    color: AppColors.accentColor,
                    splashColor: AppColors.darkColor,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ]),
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
