import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:foose_gsc/ui/pages/pages.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _currentIndex = 0;
  final List<Widget> _childrenPage = [
    const ArticlePage(),
    const RecipePage(),
    const ScanPage(),
    const FoodStockPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _childrenPage[_currentIndex],
      // // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 10),
      //   child: CustomBott(
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: AppColors.primaryColor,
      //     onTap: onTabTapped,
      //     currentIndex: _currentIndex,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.article),
      //         label: 'Article',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.local_dining),
      //         label: 'Recipe',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.scanner),
      //         label: 'scan',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.food_bank),
      //         label: 'FoodStock',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .17125,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == _currentIndex ? screenWidth * .12 : 0,
                      width: index == _currentIndex ? screenWidth * .17125 : 0,
                      decoration: BoxDecoration(
                        color: index == _currentIndex
                            ? AppColors.backgroundColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .17125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == _currentIndex
                        ? AppColors.primaryColor
                        : AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<IconData> listOfIcons = [
    Icons.article,
    Icons.menu_book,
    Icons.document_scanner,
    Icons.restaurant,
    Icons.person_rounded,
  ];
}
