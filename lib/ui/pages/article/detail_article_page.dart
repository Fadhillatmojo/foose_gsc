import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class DetailArticlePage extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  final String imageUrl;
  final String createdAt;
  const DetailArticlePage({
    super.key,
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.author,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.createdAt,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover, // Crop and maintain aspect ratio
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.content,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 16,
                    ),
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
