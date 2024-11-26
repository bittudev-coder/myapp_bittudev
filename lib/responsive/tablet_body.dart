import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/ConstColor.dart';
import '../Constant/ConstString.dart';
import '../Content/MyAppbar.dart';
import '../Content/MyDrawer.dart';
import '../Content/autoswipecontent.dart';
import '../WidgetTool/CustomButton.dart';
import '../WidgetTool/HeadShow.dart';
import '../WidgetTool/Ui/Custopm_bottom_paint.dart';
import '../WidgetTool/Ui/Tablet_top_paint.dart';
import '../WidgetTool/Ui/custom_top_paint.dart';
import '../WidgetTool/showHeadId.dart';
import '../controllers/auth_service.dart';
import '../util/my_tile.dart';
import '../util/user__repository.dart';
import '../views/WebView.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  late SharedPreferences prefs;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool isDarkMode = false;
  bool isSearchMode = false;
  TextEditingController textEditingController = TextEditingController();

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void toggleSearchMode() {
    setState(() {
      isSearchMode = !isSearchMode;
    });
  }




  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      key: _drawerKey,
      drawer: myDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeader(width),
          Expanded(child:
            Text("Hello")
          ),
          _buildMainContent(),
          _buildFooter(width),
        ],
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Container(
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, (350 * 0.41473214285714285).toDouble()),
            painter: TabletTopPaint(),
          ),
          _buildMenuButton(),
          _buildHeaderContent(width),
        ],
      ),
    );
  }

  Widget _buildMenuButton() {
    return Positioned(
      top: 40,
      left: 10,
      child: InkWell(
        onTap: () {
          _drawerKey.currentState!.openDrawer();
        },
        child: ClipOval(
          child: Container(
            color: headColor,
            width: 60.0,
            height: 60.0,
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContent(double width) {
    return Positioned(
      left: 160,
      top: 20,
      child: Container(
        width: width - 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            if (width > 750)
              if (isSearchMode && width < 1300)
                Container()
              else
                const HeadshowText(txtSize: 30),
            if (isSearchMode)
              SizedBox(
                width: 250,
                height: 50,
                child: CustomInputField(
                  textEditingController: textEditingController,
                ),
              ),
            _buildSearchAndDarkModeIcons(width),

          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndDarkModeIcons(double width) {
    return Row(
      children: [
        IconButton(
          color: Colors.white,
          onPressed: toggleSearchMode,
          icon: Icon(isSearchMode ? Icons.close : Icons.search),
          iconSize: 30,
        ),
        SizedBox(width: 30),
        if (width < 750 && !isSearchMode)
          IconButton(
            color: Colors.white,
            onPressed: toggleDarkMode,
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            iconSize: 30,
          ),
        if (width > 750)
          IconButton(
            color: Colors.white,
            onPressed: toggleDarkMode,
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            iconSize: 30,
          ),
        SizedBox(width: 20,),
        _buildLoginButton(width),
      ],
    );
  }

  Widget _buildLoginButton(double width) {
    if (width < 750 && !isSearchMode) {
      return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,):
      CustomButton(text: login,onTap: (){
        Navigator.pushNamed(context, "/login");
      },);
    }
    if (width > 750) {
      return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,):
      CustomButton(text: login,onTap: (){
        Navigator.pushNamed(context, "/login");
      },);
    }
    return Container();
  }

  Widget _buildMainContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Based on your birthdate, I will calculate how many days are left until your next birthday.',
        style: TextStyle(
          fontSize: 18,
          height: 1.5,
          fontWeight: FontWeight.w400,
          fontFamily: 'roboto',
          color: bodyColor,
        ),
      ),
    );
  }

  Widget _buildFooter(double width) {
    return Container(
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, (399 * 0.31473214285714285).toDouble()),
            painter: CustomBottomPaint(),
          ),
          _buildChatButton(),
        ],
      ),
    );
  }

  Widget _buildChatButton() {
    return Positioned(
      bottom: 40,
      right: 20,
      child: InkWell(
        onTap: () {
          print("Button Pressed!");
        },
        child: ClipOval(
          child: Container(
            color: headColor,
            width: 60.0,
            height: 60.0,
            child: Center(
              child: Icon(
                Icons.mark_unread_chat_alt_outlined,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
