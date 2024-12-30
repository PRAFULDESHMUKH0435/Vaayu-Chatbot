import 'dart:convert';
import 'package:http/http.dart';
import 'package:vaayu_chatbot/data/Network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import '../../res/appconstants.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getBotResponse(String prompt) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(Uri.parse(AppConstants.chatboturl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppConstants.ChatbotAPIKey}"
          },
          body: jsonEncode({
            "model": "gpt-4o-mini",
            "messages": [
              {"role": "developer", "content": prompt}
            ]
          })).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final res = getResponse(response);
        var ans = res['choices'][0]['message']['content'];
        return ans;
      }else{
        return response.body;
      }
    } catch (e) {
      print("Exception : $e");
    }
  }

  getResponse(Response response) {
    dynamic jsonResponse;
    switch (response.statusCode) {
      case 200:
        jsonResponse = jsonDecode(response.body);
        return jsonResponse;

      case 404:
      case 400:
        return jsonDecode(response.body);
    }
  }
}
