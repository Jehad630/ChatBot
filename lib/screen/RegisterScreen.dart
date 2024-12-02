import 'package:chatbot/helper/showsnakbar.dart';
import 'package:chatbot/screen/home_page.dart';
import 'package:chatbot/screen/LoginScreen.dart';
import 'package:chatbot/screen/message_screen.dart';
import 'package:chatbot/widgets/Constants.dart';
import 'package:chatbot/widgets/CustomButton.dart';
import 'package:chatbot/widgets/CustomTextFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 
 String? email,password;

 bool isloading = false;

 GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Colors.deepPurple/*kprimaryColor*/,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              
              children: [
                const SizedBox(height: 75,),
               Image.asset("assets/images/chatbot_13086996.png",height: 250,),
                const Text(
                  "ChatBot",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'pacifico',
                
                  ),
                  
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: "pacifico",
                      ),           
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                customTextFiled(
                  // to take the data from the filed 
                  onChanged: (data) {
                    email=data;
                  },
                  hintText: "Email",
                ),
                const SizedBox(height: 10),
                customTextFiled(
                  // to take the data from the filed 
                  onChanged: (data) {
                    password=data;
                  },
                  hintText: "Password",
                ),
                const SizedBox(height: 20),
                // to send the email and password to the firebase 
                 CustomButton(
                  onTap: () async {
                    // the if condition used for
                    // if the enterd ivformation matches the rules start the code inside it .
                 if (formKey.currentState!.validate()) 
                 {
                     isloading=true;
                     setState(() {});
                     try 
                     {
                        await registerUser();
                        Navigator.pushNamed(context,HomePage.id);
                     }
                     on  FirebaseAuthException catch (ex) {
                      // the error message to the user
                      if (ex.code == 'weak-password') 
                         {
                          ShowSnackBar(context,"The password provided is too weak.");
                         } 
                      else if (ex.code == 'email-already-in-use')
                       {
                        ShowSnackBar(context, "The account already exists for that email."); 
                       }
                     }
                     catch(ex){
                      ShowSnackBar(context, "there was an error creating the account");
                               
                     }
                     isloading=false;
                     setState(() {});
                 }
                 else{} },
                 
                 text: "Register",
                 ),
                const SizedBox(height: 15), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account?", style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen().id);
                      },
                      child: 
                      const Text(" Login"
                      , 
                      style: TextStyle(
                        color: Color(0xffC7EDE6)
                        ))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  Future<void> registerUser() async {
     UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email!, password: password!);
  }
}

