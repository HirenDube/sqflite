import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with SingleTickerProviderStateMixin {
  List<BottomNavigationBarItem> tabIcons = [
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.nightlight),
        icon: Icon(
          Icons.nightlight,
          color: Colors.white,
        ),
        label: "Night"),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.sunny),
        icon: Icon(
          Icons.sunny,
          color: Colors.white,
        ),
        label: "Day"),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.ac_unit),
        icon: Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
        label: "Cold")
  ];

  var tabView = [
    Center(
      child: Icon(Icons.nightlight),
    ),
    Center(
      child: Icon(Icons.sunny),
    ),
    Center(
      child: Icon(Icons.ac_unit),
    )
  ];

  int currentPage = 0;

  DateTime? currentPressedTime;

  Future<bool> shouldPop() {
    currentPressedTime = DateTime.now();
    if (currentPressedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tab BAck again !! to exit the app")));
      return Future.value(false);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: shouldPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bottom Tab Bar"),
          actions: [
            OutlinedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.deepOrange,
                ))
          ],
        ),
        body: tabView[currentPage],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: currentPage,
            items: tabIcons,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            }),
      ),
    );
  }
}

// Material(
//           color: Colors.black,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           child: TabBar(
//             splashBorderRadius: BorderRadius.circular(20),
//             indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.green,
//                 border: Border.all(width: 3,color: Colors.grey,
//                 ),gradient: RadialGradient(colors: [Colors.black,Colors.green])
//             ),
//             automaticIndicatorColorAdjustment: true,
//             indicatorColor: Colors.green,
//             tabs: tabIcons,
//             controller: bottomTabConroller,
//           ))
