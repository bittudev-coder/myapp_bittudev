import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


import '../Constant/ConstColor.dart';
import '../Content/MyAppbar.dart';
import '../Content/MyDrawer.dart';
import '../Content/autoswipecontent.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class AndroidPage extends StatefulWidget {
  const AndroidPage({Key? key}) : super(key: key);

  @override
  State<AndroidPage> createState() => _MobileScaffoldState();
}
class _MobileScaffoldState extends State<AndroidPage> {


  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            mobileWidgets(),

            Text('services'),
            Text("about"),
            Text("Contact"),
            Text("Signup"),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
          child: BottomBarFloating(
            iconSize: 22,
            enableShadow: true,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 5),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 10),
                blurRadius: 10.0,
                spreadRadius: 0,
              ),
            ],
            titleStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'fonts/OpenSans-Light.ttf',
              letterSpacing: 0,
              fontSize: 12,
            ),
            items: _bottomNavigationBarItems,
            backgroundColor: bodyColor,
            color: Color.fromARGB(255, 4, 4, 4),
            colorSelected: headColor,
            indexSelected: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                // Update live and list states based on index

              });
            },

          ),
        ),

      ),
    );
  }
  List<TabItem> get _bottomNavigationBarItems => [
    TabItem(
      icon: _selectedIndex == 0
          ? Icons.dashboard
          : Icons.dashboard_outlined,
      title: 'Home',
    ),
    TabItem(
      icon: _selectedIndex == 1
          ? Icons.miscellaneous_services
          : Icons.miscellaneous_services_outlined,
      title: 'Services',
    ),
    TabItem(
      icon: _selectedIndex == 2
          ? Icons.person
          : Icons.person_outline,
      title: 'Abouts',
    ),
    TabItem(
      icon: _selectedIndex == 3
          ? Icons.call
          : Icons.call_outlined,
      title: 'Contact',
    ),  TabItem(
      icon: _selectedIndex == 4
          ? Icons.account_circle
          : Icons.account_circle_outlined,
      title: 'Account',
    ),
  ];
}



// navigator bar add


class mobileWidgets extends StatefulWidget {
  const mobileWidgets({super.key});

  @override
  State<mobileWidgets> createState() => _mobileWidgetsState();
}


class _mobileWidgetsState extends State<mobileWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      // drawer: myDrawer,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // first 4 boxes in grid
            AspectRatio(
              aspectRatio: 2.5,
              child: SizedBox(
                width: double.infinity,
                child: AutoSwipePageView(),
              ),
            ),

            // list of previous days
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const MyTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


