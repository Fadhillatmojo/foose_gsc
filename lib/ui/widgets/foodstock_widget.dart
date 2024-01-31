import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class FoodStockWidget extends StatelessWidget {
  final String name;
  final String quantity;
  final String expirationDuration;
  final String purchaseDate;

  const FoodStockWidget(
      this.name, this.quantity, this.expirationDuration, this.purchaseDate,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Customize the UI for displaying each article
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // function buat munculin bottom pop up detail
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // setiap row nya isinya adalah icon trash, nama food, total quantity
          children: [
            Text(
              name,
              maxLines: 1, // Set the maximum number of lines
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'X $quantity',
              maxLines: 1, // Set the maximum number of lines
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
