import 'package:flutter/material.dart';

class UiHelper {
  static CustomButton(
      {required VoidCallback callback, required String buttonname}) {
    return SizedBox(
      height: 45,
      width: 350,
      child: ElevatedButton(
          onPressed: () {
            callback();
          },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)
      )),
          child: Text(
            buttonname,
            style: TextStyle(fontSize: 14, color: Colors.white),
          )),
    );
  }

  static CustomText(
      {required String text,
      required double height,
      Color? color,
      FontWeight? fontweight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: height,
        color: color ?? Color(0XFF5E5E5E),
        fontWeight: fontweight
      ),
    );
  }

  static Widget CustomContainer(TextEditingController controller, FocusNode currentFocusNode, FocusNode nextFocusNode, Function onOTPChanged) {
    return Container(
      height: 50, // Height of the input field
      width: 40, // Width of the input field
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        color: Color(0XFFD9D9D9), // Background color
        border: Border.all(color: Colors.grey, width: 1), // Border styling
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: currentFocusNode,
          textAlign: TextAlign.center, // Center the digit inside the field
          decoration: InputDecoration(
            border: InputBorder.none, // Removes the default border
            counterText: '', // Removes the counter text (optional)
          ),
          keyboardType: TextInputType.number, // Allows only numbers
          maxLength: 1, // Only allows 1 digit to be entered
          style: TextStyle(
            fontSize: 32, // Larger font for OTP digit
            fontWeight: FontWeight.bold, // Bold text style
          ),
          onChanged: (value) {
            onOTPChanged(value, currentFocusNode, nextFocusNode, currentFocusNode);
          },
        ),
      ),
    );
  }


}
