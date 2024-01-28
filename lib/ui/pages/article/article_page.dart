import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:foose_gsc/ui/widgets/widgets.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final TextEditingController searchController = TextEditingController();

  String imageUrl = '';
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('articles').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    // email field untuk login
    final searchField = TextFormField(
      autofocus: false,
      controller: searchController,
      onSaved: (value) {
        searchController.text = value!;
      },
      style: const TextStyle(color: AppColors.primaryColor),
      cursorColor: AppColors.primaryColor,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: AppColors.primaryColor,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        hintText: 'Search Article',
        hintStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              searchField,
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  var articles = snapshot.data!.docs;
                  List<Widget> articleWidgets = [];

                  for (var article in articles) {
                    var title = article['title'];
                    var author = article['author'];
                    var content = article['content'];
                    var imageUrl = article['imageUrl'];
                    var createdAtTimestamp = article['created_at'];

                    // Konversi Timestamp ke DateTime dan kemudian ke dalam String dengan format yang diinginkan
                    var createdAtDateTime =
                        (createdAtTimestamp as Timestamp).toDate();
                    var createdAt = DateFormat('dd MMMM yyyy HH:mm')
                        .format(createdAtDateTime);

                    // Assuming you have a separate widget for displaying articles
                    var articleWidget = ArticleWidget(
                        title, author, content, imageUrl, createdAt);
                    articleWidgets.add(articleWidget);
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: articleWidgets,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
