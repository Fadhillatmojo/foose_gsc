import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class ArticleWidget extends StatelessWidget {
  final String title;
  final String author;
  final String content;
  final String imageUrl;
  final String createdAt;

  const ArticleWidget(
      this.title, this.author, this.content, this.imageUrl, this.createdAt,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Customize the UI for displaying each article
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), // Radius for top left corner
              bottomLeft: Radius.circular(8.0), // Radius for bottom left corner
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, // Crop and maintain aspect ratio
              width: 108,
              height: 128,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    maxLines: 1, // Set the maximum number of lines
                    style: const TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                      height: 8), // Add some space between author and title
                  Text(
                    title,
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow
                        .ellipsis, // Show ellipsis when text overflows
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                      height: 8), // Add some space between title and createdAt
                  Text(
                    createdAt,
                    style: const TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
