import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vaayu_chatbot/res/appstyles.dart';
import 'package:vaayu_chatbot/res/enums.dart';
import 'package:vaayu_chatbot/utils/Routes/Utils.dart';

import '../view-model/chatbotviewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    ChatBotViewModel().initializeSharedPreferences();
    super.initState();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatbotviewmodel = Provider.of<ChatBotViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/ai_hand_waving.json",
              width: 50,
              height: 50,
            ),
            Text(
              "Vaayu AI Chatbot",
              style: AppStyles.apptitlestryle,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          /// Expanded
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chatbotviewmodel.messages.length,
              itemBuilder: (context, index) {
                if (chatbotviewmodel.messages.isEmpty) {
                  return Center(
                    child: Text(
                      "No Messages Available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                final messagedata =
                    chatbotviewmodel.messages[index]; // Get message safely
                if(messagedata.sender==MessageSender.User){
                  return Container(
                    padding:EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(14.0))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         CircleAvatar(
                          radius: 20,
                          child: Lottie.asset("assets/lottie/ai_play.json"),),
                          SizedBox(width: 8,),
                          Flexible(child: Text(messagedata.message))
                      ],
                    ),
                  );
                } else{
                  return Container(
                    padding:EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(14.0))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         CircleAvatar(
                          radius: 25,
                          child: Lottie.asset("assets/lottie/ai_hand_waving.json"),),
                          SizedBox(width: 8,),
                          Flexible(child: Text(messagedata.message,overflow:TextOverflow.ellipsis,maxLines: 20,))
                      ],
                    ),
                  );
                }
              },
            ),
          ),

          /// TextField
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(4.0),
            child: TextField(
              controller: chatbotviewmodel.chatcontroller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      if (chatbotviewmodel.chatcontroller.text
                          .toString()
                          .trim()
                          .isEmpty) {
                        Utils.showsnackbar(
                            context, "Please Input message", Colors.green);
                      } else {
                        chatbotviewmodel.AddMessageToList(chatbotviewmodel
                            .chatcontroller.text
                            .toString()
                            .trim());
                        chatbotviewmodel.getBotResponse(
                            context,
                            chatbotviewmodel.chatcontroller.text
                                .toString()
                                .trim());
                      }
                    },
                    icon: chatbotviewmodel.isloading
                        ? CircularProgressIndicator()
                        : Icon(Icons.send,color: Colors.pink,)),
                hintText: "Ask Me A Question...",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
