import 'package:chatbot/screen/message_screen.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  static String id = "HomePage";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for requesting instins that we download from dialogflow 
  late DialogFlowtter dialogFlowtter;
  // here so we can send our meesages 
  final TextEditingController _controller= TextEditingController();

  List<Map<String,dynamic>> messages=[];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) =>dialogFlowtter = instance);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("ChatBot ",
            style: TextStyle(
              fontFamily: 'pacifico',
            ),),
            Icon(Icons.message),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //Messages which be comming from MessageScreen 
            Expanded(child: MessageScreen(meesages: messages,)),
            //MyTextFromFiled
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                  ),
                  ),
                  // send button
                  IconButton(onPressed: (){
                    SendMessage(_controller.text);
                     _controller.clear();
                  },
                   icon: const Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // here we take the meesage from the user adding it to the list
  SendMessage(String text) async {
    if(text.isEmpty){
      print("Message is empty");
    }
    else{
      setState(() {
        addMessage(Message(text: DialogText(text:[text] )),
        true,
        );
      });
    }
    //and here we write the message from the bot to the screen
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text:TextInput(text: text)));

      if(response.message == null){
        return;
      }
      else{
        setState(() {
          addMessage(response.message!);
        });
        //addMessage(Message(text:DialogText(text: [text])));
      }
  }
  // here we can know from which side the message comeing from
  addMessage(Message message,[bool isUserMessage=false]){
    //here we are adding to the list
    messages.add({"message": message, "isUserMessage": isUserMessage});
  }
}