import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/ConstColor.dart';
import '../Constant/ConstString.dart';
import '../Content/MyDrawer.dart';
import '../Function/Function.dart';
import '../WidgetTool/CustomButton.dart';
import '../WidgetTool/HeadShow.dart';
import '../WidgetTool/Ui/Custopm_bottom_paint.dart';
import '../WidgetTool/Ui/Tablet_top_paint.dart';
import '../WidgetTool/showHeadId.dart';
import '../controllers/auth_service.dart';
import '../util/user__repository.dart';



class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late SharedPreferences prefs;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool isDarkMode = false;
  bool isSearchMode = false;
  double _iconSize=20;
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
    return  Scaffold(
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
            width: 40.0,
            height: 40.0,
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContent(double width) {
    return Positioned(
      left: 80,
      top: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show HeadshowText if width > 750 and not in search mode, or if search mode is not active
            if (width > 750 && !(isSearchMode && width < 1300))
              const HeadshowText(txtSize: 30),

            // Show search field when in search mode
            if (isSearchMode)
              SizedBox(
                width: 200,
                height: 40,
                child: CustomInputField(
                  textEditingController: textEditingController,
                ),
              ),

            // Display search and dark mode icons
            _buildSearchAndDarkModeIcons(width),
            SizedBox(
              width: 20,
            )
          ],
        ),
      )
      ,
    );
  }

  Widget _buildSearchAndDarkModeIcons(double width) {
    return Row(
      children: [
        IconButton(
          color: Colors.white,
          onPressed: toggleSearchMode,
          icon: Icon(isSearchMode ? Icons.close : Icons.search),
          iconSize: _iconSize,
        ),
        SizedBox(width: _iconSize),
        if (width < 750 && !isSearchMode)
          IconButton(
            color: Colors.white,
            onPressed: toggleDarkMode,
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            iconSize: _iconSize,
          ),
        if (width > 750)
          IconButton(
            color: Colors.white,
            onPressed: toggleDarkMode,
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            iconSize: _iconSize,
          ),
        SizedBox(width: _iconSize-10,),
        _buildLoginButton(width),
      ],
    );
  }

  Widget _buildLoginButton(double width) {
    if (width < 750 && !isSearchMode) {
      return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,name: UserRepository.getName()!,):
      CustomButton(text: login,onTap: (){
        showReportDialog(context,true);
      },);
    }
    if (width > 750) {
      return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,name: UserRepository.getName()!,):
      CustomButton(text: login,onTap: (){
        showReportDialog(context,true);
      },);
    }
    return Container();
  }


  // MAin Content
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


  // Fotter
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
      right: 10,
      child: InkWell(
        onTap: ()async {
          bool isUserLoggedin = await AuthService.isLoggedIn();
          if(isUserLoggedin){
            Navigator.pushNamed(context, '/chat');
          }else{
            showReportDialog(context,true);
          }
        },
        child: ClipOval(
          child: Container(
            color: headColor,
            width: 40.0,
            height: 40.0,
            child: Center(
              child: Icon(
                Icons.mark_unread_chat_alt_outlined,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
