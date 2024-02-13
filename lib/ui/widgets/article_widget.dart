import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:foose_gsc/ui/pages/article/detail_article_page.dart';

class ArticleWidget extends StatefulWidget {
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
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  Color _containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Customize the UI for displaying each article
    return GestureDetector(
      onTap: () {
        // Ubah warna kontainer menjadi abu-abu sejenak ketika diklik
        setState(() {
          _containerColor = AppColors
              .microInteractionGreyColor; // Warna abu-abu dengan opasitas 0.5
        });

        // Kembalikan warna kontainer ke semula setelah beberapa waktu
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _containerColor = Colors.white; // Kembalikan ke transparan
          });
        });
        // Navigasi ke halaman detail dan kirimkan data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArticlePage(
              title: widget.title,
              author: widget.author,
              content: widget.content,
              imageUrl: widget.imageUrl,
              createdAt: widget.createdAt,
            ),
          ),
        );
      },
      child: Card(
        color: _containerColor,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0), // Radius for top left corner
                bottomLeft:
                    Radius.circular(8.0), // Radius for bottom left corner
              ),
              child: Image.network(
                widget.imageUrl,
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
                      widget.author,
                      maxLines: 1, // Set the maximum number of lines
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                        height: 8), // Add some space between author and title
                    Text(
                      widget.title,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis when text overflows
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                        height:
                            8), // Add some space between title and createdAt
                    Text(
                      widget.createdAt,
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
      ),
    );
  }
}
