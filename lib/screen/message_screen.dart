import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
   MessageScreen({super.key, required this.meesages});
  final List meesages;

   String id = "MessageScreen";
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  ListView.separated(
      separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.meesages.length, 
      itemBuilder: ( context,  index) { 

        // this widget for the meesages 
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: widget.meesages[index]["isUserMessage"]
            ?MainAxisAlignment.end
            :MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20),
                    topLeft: const Radius.circular(20),
                    bottomRight: Radius.circular(widget.meesages[index]["isUserMessage"]?0:20),
                    topRight: Radius.circular(widget.meesages[index]["isUserMessage"]?20:0),
                    
                    ),
                    color: widget.meesages[index]["isUserMessage"]
                ?Colors.deepPurple
                :Colors.green.shade800,
                ),
                
                constraints: BoxConstraints(maxWidth: width* 2 / 3),
                child: Text(widget.meesages[index]["message"].text.text[0],style: const TextStyle(color: Colors.white),),
              )
            ],
          ),
        );
       },
    );
  }
}