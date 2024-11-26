// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// var position=Positioned(
//   left: 160,
//   top: 20,
//   child: Container(
//     width: width - 200,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(width: 20),
//         if (width > 750)
//           if (isSearchMode && width < 1300)
//             Container()
//           else
//             const HeadshowText(txtSize: 30),
//         if (isSearchMode)
//           SizedBox(
//             width: 250,
//             height: 50,
//             child: CustomInputField(
//               textEditingController: textEditingController,
//             ),
//           ),
//         _buildSearchAndDarkModeIcons(width),
//
//       ],
//     ),
//   ),
// );
// Widget _buildSearchAndDarkModeIcons(double width) {
//   return Row(
//     children: [
//       IconButton(
//         color: Colors.white,
//         onPressed: toggleSearchMode,
//         icon: Icon(isSearchMode ? Icons.close : Icons.search),
//         iconSize: 30,
//       ),
//       SizedBox(width: 30),
//       if (width < 750 && !isSearchMode)
//         IconButton(
//           color: Colors.white,
//           onPressed: toggleDarkMode,
//           icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
//           iconSize: 30,
//         ),
//       if (width > 750)
//         IconButton(
//           color: Colors.white,
//           onPressed: toggleDarkMode,
//           icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
//           iconSize: 30,
//         ),
//       SizedBox(width: 20,),
//       _buildLoginButton(width),
//     ],
//   );
// }
//
// Widget _buildLoginButton(double width) {
//   if (width < 750 && !isSearchMode) {
//     return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,):
//     CustomButton(text: login,onTap: (){
//       Navigator.pushReplacementNamed(context, "/login");
//     },);
//   }
//   if (width > 750) {
//     return UserRepository.getLoginState()? CustomContainer(text: UserRepository.getEmail()!,):
//     CustomButton(text: login,onTap: (){
//       Navigator.pushReplacementNamed(context, "/login");
//     },);
//   }
//   return Container();
// }