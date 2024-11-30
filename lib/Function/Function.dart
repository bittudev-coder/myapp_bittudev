
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controllers/auth_service.dart';
import '../controllers/notification_service.dart';
import '../util/user__repository.dart';






void showReportDialog(BuildContext context,bool route) {
  bool signupIfLogin = true; // Initialize this state outside of the builder
  double width=380;
  Dialog simpleDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: 400, // Fixed width of the signup form
          height: width, // Fixed height of the signup form
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center ,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                // Toggle between Login and SignUp based on signupIfLogin value
                signupIfLogin ? LoginField(route: route,) : SignUpField(route: route,),
                // Conditional Row for toggling between Login/SignUp
                signupIfLogin
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No account?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          width=450;
                          signupIfLogin = false; // Switch to sign-up
                        });
                      },
                      child: Text("Register"),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          width=380;
                          signupIfLogin = true; // Switch to login
                        });
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) => simpleDialog,
  );
}







// Signup Page Field
class SignUpField extends StatefulWidget {
  final bool route;
  SignUpField({
    Key? key,
     this.route=false, // You can now pass IconData instead of an Icon widget
  });

  @override
  State<SignUpField> createState() => _SignUpFieldState();
}

class _SignUpFieldState extends State<SignUpField> {

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Returning a Column widget
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
            onPressed:(){
              Signup(nameController.text,emailController.text,passwordController.text);
            },
              // onPressed: () async {
              //   await AuthService.createAccountWithEmail(
              //       emailController.text, passwordController.text)
              //       .then((value) async {
              //     if (value == "Account Created") {
              //       var user = FirebaseAuth.instance.currentUser;
              //       user!.updateProfile(displayName: nameController.text);
              //
              //       await _firestore.collection('users').doc(
              //           FirebaseAuth.instance.currentUser!.uid).set(
              //         {
              //           "name":nameController.text,
              //           "email":emailController.text,
              //           "status":"Unavailable",
              //         }
              //       );
              //       UserRepository.setEmail(emailController.text);
              //       UserRepository.setLoginState(true);
              //       PushNotifications.getDeviceToken();
              //       if(widget.route){
              //       Navigator.pushReplacementNamed(context, '/');}else{
              //         Navigator.pop(context);
              //       }
              //       Map<String, String> headers = {
              //         'Content-Type': 'application/json',
              //         'api-key': 'ndeweidjwekdiwwednddw'
              //       };
              //       final Map<String, dynamic> data = {
              //         "name": nameController.text,
              //         "email": emailController.text,
              //         "fcmToken":UserRepository.getToken() ,
              //
              //       };
              //       if (kDebugMode) {
              //         print(jsonEncode(data));
              //       }
              //
              //
              //         var response = await http.post(
              //           Uri.parse('https://facebackend-0uvr.onrender.com/api/v1/posts/bittudevPost'),
              //           headers: headers,
              //           body: jsonEncode(data),
              //         );
              //         final Map<String, dynamic> responseData = json.decode(response.body);
              //         if (kDebugMode) {
              //           print(responseData);
              //         }
              //         ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text("Account Created"+responseData['status'])));
              //
              //
              //       // Navigator.pushNamedAndRemoveUntil(
              //       //     context, "/", (route) => false);
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //         content: Text(
              //           value,
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         backgroundColor: Colors.red.shade400,
              //       ));
              //     }
              //   });
              // },
              child: isLoading?CircularProgressIndicator(): Text("Sign Up")),
        ),
        SizedBox(
          height: 10,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text("Already have an account?"),
        //     TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: Text("Login")),
        //   ],
        // ),
      ],
    );
  }

  void Signup(String name,String email,String password){
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      createAccount(name, email, password).then((user) async {
        if (user != null) {

                UserRepository.setEmail(email);
                UserRepository.setLoginState(true);
                UserRepository.setName(name);
                PushNotifications.getDeviceToken();
                Navigator.pushNamed(context, '/');
                setState(() {
                  isLoading = false;
                });
                Map<String, String> headers = {
                  'Content-Type': 'application/json',
                  'api-key': 'ndeweidjwekdiwwednddw'
                };
                final Map<String, dynamic> data = {
                  "name": nameController.text,
                  "email": emailController.text,
                  "fcmToken":UserRepository.getToken() ,

                };
                  var response = await http.post(
                    Uri.parse('https://facebackend-0uvr.onrender.com/api/v1/posts/bittudevPost'),
                    headers: headers,
                    body: jsonEncode(data),
                  );
                  final Map<String, dynamic> responseData = json.decode(response.body);
                  if (kDebugMode) {
                    print(responseData);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Account Created"+responseData['status'])));


          //       if(widget.route){
          //       Navigator.pushReplacementNamed(context, '/');}else{
          //         Navigator.pop(context);
          //       }


          // print("Account Created Sucessfull");
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text()));
          print("Login Failed");
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter Fields")));
    }
  }
}


//Login APge Field

class LoginField extends StatefulWidget {

  final bool route;
  LoginField({
    Key? key,
    this.route=false, // You can now pass IconData instead of an Icon widget
  });

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // Returning a Column widget
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
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
                  onPressed: (){
                    LoginFunc(emailController.text,passwordController.text);
                  },
                    // onPressed: () async {
                    //   await AuthService.loginWithEmail(
                    //       emailController.text, passwordController.text)
                    //       .then((value) {
                    //         UserRepository.setLoginState(true);
                    //         UserRepository.setEmail(emailController.text);
                    //     if (value == "Login Successful") {
                    //       if(widget.route) {
                    //         Navigator.pushReplacementNamed(context, '/');
                    //       }else{
                    //         Navigator.pop(context);
                    //       }
                    //
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(content: Text("Login Successful")));
                    //
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //           value,
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //         backgroundColor: Colors.red.shade400,
                    //       ));
                    //     }
                    //   });
                    // },



                    child: isLoading?CircularProgressIndicator(): Text("Login")),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
 void LoginFunc(String email,String paassword){
   if (email.isNotEmpty && paassword.isNotEmpty) {
     setState(() {
       isLoading = true;
     });

     logIn(email, paassword).then((user) {
       if (user != null) {
                 UserRepository.setLoginState(true);
                 UserRepository.setEmail(email);
                 UserRepository.setName(user.displayName!);

                       ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Login Successful")));

                     // if (value == "Login Successful") {
                     //   if(widget.route) {
                     //     Navigator.pushReplacementNamed(context, '/');
                     //   }else{
                     //     Navigator.pop(context);
                     //   }
                Navigator.pushNamed(context, '/');
                 setState(() {
                   isLoading = false;
                 });

       } else {
         print("Login Failed");
         setState(() {
           isLoading = false;
         });
       }
     });
   } else {
     print("Please fill form correctly");
   }
 }



}

