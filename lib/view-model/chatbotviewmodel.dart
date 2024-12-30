import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaayu_chatbot/model/MessageDataModel.dart';
import 'package:vaayu_chatbot/repository/chatbotrepository.dart';
import 'package:vaayu_chatbot/utils/Routes/Utils.dart';

import '../res/enums.dart';

class ChatBotViewModel with ChangeNotifier {
  final chatcontroller = TextEditingController();
  final repository = ChatBotRepository();
  List<MessageDataModel> messages = [];

  /// Loading Status
  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  /// Internet Status
  bool _internetavailable = true;
  bool get internetavailable => _internetavailable;
  set internetavailable(bool value) {
    _internetavailable = value;
    notifyListeners();
  }

  Future getBotResponse(BuildContext context, prompt) async {
    await CheckInternetConnection(context);
    await repository.getBotResponse(prompt).then((value) {
      isloading = false;
      chatcontroller.clear();
      print("Response is : $value");
      MessageDataModel model = MessageDataModel(message: value, sender: MessageSender.Bot);
      messages.add(model);
    }).onError((error, stackTrace){
      isloading = false;
      MessageDataModel model = MessageDataModel(message: "No Internet Found ,Check Your Internet Connection", sender: MessageSender.Bot);
      messages.add(model);
      print("Error is : $error");
    });
    notifyListeners();
  }

  initializeSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
  }

  AddMessageToList(String message) async {
    MessageDataModel model = MessageDataModel(message: message, sender: MessageSender.User);
    messages.add(model);
    notifyListeners();
  }

  CheckInternetConnection(BuildContext context) async {
    isloading = true;
    notifyListeners();
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.vpn) ||
        connectivityResult.contains(ConnectivityResult.bluetooth) ||
        connectivityResult.contains(ConnectivityResult.other)) {
      print(" INTERNET AVAILABLE WITH $connectivityResult");
      _internetavailable = true;
      notifyListeners();
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      _internetavailable = false;
      _isloading = false;
      notifyListeners();
      Utils.showsnackbar(context, "No Internet Connection", Colors.red);
      print("NO INTERNET AVAILABLE");
    }
  }
}
