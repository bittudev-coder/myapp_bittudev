import 'package:flutter/material.dart';
import '../Constant/ConstColor.dart';
import '../Constant/ConstString.dart';
import '../Content/MyDrawer.dart';
import '../Function/Function.dart';
import '../WidgetTool/CustomButton.dart';
import '../WidgetTool/HeadShow.dart';
import '../WidgetTool/Ui/Custopm_bottom_paint.dart';
import '../WidgetTool/Ui/custom_top_paint.dart';
import '../WidgetTool/showHeadId.dart';
import '../WidgetTool/uihelper.dart';
import '../controllers/auth_service.dart';
import '../util/user__repository.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  _DesktopScaffoldState createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
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
      body: Row(
        children: [
           myDrawer(context),  // Assuming myDrawer is already optimized

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(width),
                Expanded(child: Container(
                  // color: Colors.grey,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiHelper.CustomText(text:'Find & Hire', height: 50,fontweight: FontWeight.w700,color: Colors.black),
                          UiHelper.CustomText(text:'Expert FreeLancers', height: 50,fontweight: FontWeight.w700,color: Colors.black),
                          UiHelper.CustomText(text:Wrok_with, height: 20,fontweight: FontWeight.w700,color: Colors.black),
                          UiHelper.CustomText(text:Wrok_with1, height: 20,fontweight: FontWeight.w700,color: Colors.black),
                        ],
                      ),
                      Image.asset('assets/bittulogo.png')
                    ],
                  ),
                )),
                _buildMainText(),
                _buildFooter(width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(width, 350 * 0.41473214285714285),
          painter: CustomTopPaint(),
        ),
        Positioned(
          left: 20,
          top: 25,
          child: Container(
            width: MediaQuery.of(context).size.width - 340,  // Ensure the container has enough width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // This distributes the space evenly
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                // HeadshowText with custom size
                (isSearchMode && width<1300)?
                new Container():const HeadshowText(txtSize: 30),
                // TextInputField inside a container with fixed height and width
                isSearchMode? SizedBox(
                  width: 350,
                  height: 50,
                  child: CustomInputField(
                    textEditingController: textEditingController,
                  ),
                ):new Container(),

                // Search/Close Icon button (conditionally rendered)
                Row(children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: toggleSearchMode,
                    icon: Icon(isSearchMode ? Icons.close : Icons.search),
                    iconSize: 30,
                  ),
                SizedBox(width: 30,),
                  // Dark mode toggle Icon button
                  IconButton(
                    color: Colors.white,
                    onPressed: toggleDarkMode,
                    icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                    iconSize: 30,
                  ),
                  SizedBox(width: 30,),
                  // Custom button (e.g., login)
                  UserRepository.getLoginState()?CustomContainer(text: UserRepository.getEmail()!,name: UserRepository.getName()!,):CustomButton(text: login,onTap: (){
                    showReportDialog(context,true);
                  },),
                ],)
              ],
            ),
          ),
        )



      ],
    );
  }

  Widget _buildMainText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
    return Stack(
      children: [
        CustomPaint(
          size: Size(width, 399 * 0.31473214285714285),
          painter: CustomBottomPaint(),
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: InkWell(
            onTap: ()async{
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
                width: 60.0,
                height: 60.0,
                child: const Center(
                  child: Icon(
                    Icons.mark_unread_chat_alt_outlined,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
