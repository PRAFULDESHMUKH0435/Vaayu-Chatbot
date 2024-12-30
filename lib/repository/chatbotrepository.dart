import 'package:vaayu_chatbot/data/Network/BaseApiServices.dart';
import 'package:vaayu_chatbot/data/Network/NetworkApiServices.dart';

class ChatBotRepository{

  BaseApiServices apiservices = NetworkApiServices();
  Future  getBotResponse(String prompt) async{
      try{
       final response = await apiservices.getBotResponse(prompt);
       return response;
      }catch(e){
        rethrow;
      }
  }
}