import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class AddFoodStock extends StatefulWidget {
  const AddFoodStock({super.key});

  @override
  State<AddFoodStock> createState() => _AddFoodStockState();
}

class _AddFoodStockState extends State<AddFoodStock> {
  @override
  void initState() {
    super.initState();
    // _authBloc = AuthBloc();
  }

  final _formKey = GlobalKey<FormState>();
  String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, dynamic>> _foodStockList = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _addFoodStock() {
    setState(() {
      _foodStockList.add({
        'stockName': '',
        'quantity': 0,
      });
    });
  }

  void _saveFoodStock() {
    if (_foodStockList.isNotEmpty) {
      // Simpan data ke Firebase Firestore
      // for (var foodStock in _foodStockList) {
      //   FirebaseFirestore.instance.collection('food_stock').add(foodStock);
      // }
      // Clear list setelah disimpan
      _foodStockList.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // add button to add stock item
    final addButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(20),
      color: AppColors.accentColor,
      child: SizedBox(
        width: 120, // Atur lebar tetap di sini
        child: MaterialButton(
          onPressed: () {},
          splashColor: AppColors.darkColor,
          highlightColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Atur radius sudut di sini
          ),
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: const Text(
            'Add Stock',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );

    // save button to save food stock to firebase add to firebase
    final saveButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      color: AppColors.accentColor,
      child: MaterialButton(
        onPressed: () {},
        splashColor: AppColors.darkColor,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Atur radius sudut di sini
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          'Save',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Food Stock',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Item',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (_foodStockList.isEmpty) ...[
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Stock Name'),
                              onChanged: (value) {
                                setState(() {
                                  _foodStockList.add({
                                    'stockName': value,
                                    'quantity': 0,
                                  });
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline_rounded,
                                  color: AppColors.darkIconColor,
                                ),
                                onPressed: _decrementCounter,
                              ),
                              Text(
                                '$_counter',
                                maxLines: 1, // Set the maximum number of lines
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: AppColors.darkIconColor,
                                ),
                                onPressed: _incrementCounter,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  for (var foodStock in _foodStockList)
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Stock Name',
                                  border: InputBorder.none,
                                  focusColor: AppColors.accentColor,
                                  fillColor: AppColors.accentColor),
                              onChanged: (value) {
                                setState(() {
                                  foodStock['stockName'] = value;
                                });
                              },
                            ),
                          ),
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
                                '${foodStock['quantity']}',
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
                    ),
                  if (_foodStockList.isNotEmpty) ...[Text('anjay')],
                ],
              ),
              SizedBox(
                height: 20,
              ),
              addButton,
              SizedBox(
                height: 50,
              ),
              saveButton,
            ],
          ),
        ),
      ),
    );
  }
}
