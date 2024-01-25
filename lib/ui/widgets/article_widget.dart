import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const ArticleWidget(this.title, this.content, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    // Customize the UI for displaying each article
    return Card(
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(title),
          Text(content),
        ],
      ),
    );
  }
}
