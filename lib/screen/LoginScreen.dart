import 'package:chatbot/helper/showsnakbar.dart';
import 'package:chatbot/screen/home_page.dart';
import 'package:chatbot/screen/RegisterScreen.dart';
import 'package:chatbot/widgets/CustomButton.dart';

import 'package:chatbot/widgets/CustomTextFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {
    LoginScreen({super.key});

  String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 String? email,password;

 bool isloading = false;    

 GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              
              children: [
                const SizedBox(height: 75,),
               Image.asset("assets/images/chatbot_13086996.png",height: 250,),
                const Row(
                   mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text(                
                      "ChatBot",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                      
                    ),
                  ],
                ),
                // const SizedBox(height: 50,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
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
                  onChanged: (data) {
                    email=data;
                  },
                  hintText: "Email",
                ),
                const SizedBox(height: 10),
                customTextFiled(
                  onChanged: (data) {
                    password=data;
                  },
                  hintText: "Password",
                ),
                const SizedBox(height: 20),
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
                        await LoginUser();
                        Navigator.pushNamed(context,HomePage.id);  
                     }
                     on  FirebaseAuthException catch (ex) {
                      // the error message to the user
                      if (ex.code == 'user-not-found') 
                         {
                          ShowSnackBar(context,'No user found for that email.');
                         } 
                      else if (ex.code == 'wrong-password')
                       {
                        ShowSnackBar(context, 'Wrong password provided for that user.'); 
                       }
                     }
                     catch(ex){
                      print(ex);
                      ShowSnackBar(context, "there was an error login the account");         
                     }
                     isloading=false;
                     setState(() {});
                 }
                 else{}
                  
                 },text: "Login",),
                const SizedBox(height: 15), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("dont have an account?", style: TextStyle(color: Colors.white)),
                    GestureDetector(
                       onTap: (){
                        Navigator.pushNamed(context, RegisterScreen().id);
                      },
                      child: 
                      const Text(" Register"
                      , 
                      style: TextStyle(
                        color: Color(0xffC7EDE6)
                        ),),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  

  Future<void> LoginUser() async {
     UserCredential user = await FirebaseAuth.instance
     .signInWithEmailAndPassword(email: email!, password: password!);
  }
}


 