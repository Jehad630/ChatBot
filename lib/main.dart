
import 'package:chatbot/screen/home_page.dart';
import 'package:chatbot/screen/LoginScreen.dart';
import 'package:chatbot/screen/RegisterScreen.dart';
import 'package:chatbot/screen/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatBot());
}
class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      darkTheme: ThemeData(brightness: Brightness.dark  ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        LoginScreen().id:(context)=> LoginScreen(),
        RegisterScreen().id:(context)=> RegisterScreen(),
        "HomePage" : (context)=> HomePage(),
        "MessageScreen" : (context)=> MessageScreen(meesages: [],),
      },
      initialRoute: LoginScreen().id,
                   
    );
  }
}