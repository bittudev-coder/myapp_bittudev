import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/auth_service.dart';
import 'package:http/http.dart' as http;
import '../controllers/notification_service.dart';
import '../util/user__repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the Scaffold to transparent
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,  // Fixed width of the signup form
            height: 450, // Fixed height of the signup form
            padding: const EdgeInsets.all(16.0), // Add padding inside the container
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the form itself
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  offset: Offset(0, 4), // Shadow direction
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon:Icon(Icons.close),iconSize: 30,onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, )
                ],),
                Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType:TextInputType.name ,
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                      hintText: "Enter your Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType:TextInputType.emailAddress ,
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      hintText: "Enter your email"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType:TextInputType.visiblePassword ,
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      hintText: "Enter your password"),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () async {
                        await AuthService.createAccountWithEmail(
                            emailController.text, passwordController.text)
                            .then((value) async {
                          if (value == "Account Created") {
                            PushNotifications.getDeviceToken();
                            Map<String, String> headers = {
                              'Content-Type': 'application/json',
                              'api-key': 'ndeweidjwekdiwwednddw'
                            };
                            final Map<String, dynamic> data = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "fcmToken":UserRepository.getToken() ,

                            };

                            try{
                            var response = await http.post(
                              Uri.parse('https://facebackend-0uvr.onrender.com/api/v1/posts/bittudevPost'),
                              headers: headers,
                              body: jsonEncode(data),
                            );
                            final Map<String, dynamic> responseData = json.decode(response.body);
                            print(responseData);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Account Created"+responseData['status'])));
                            }catch(e){}
                            UserRepository.setEmail(emailController.text);
                            UserRepository.setLoginState(true);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red.shade400,
                            ));
                          }
                        });
                      },
                      child: Text("Sign Up")),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
