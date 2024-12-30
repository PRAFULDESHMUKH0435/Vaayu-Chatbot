import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaayu_chatbot/utils/Routes/Routes.dart';
import 'utils/Routes/routenames.dart';
import 'view-model/chatbotviewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBotViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.splashscreen,
        onGenerateRoute:Routes.generateRoutes,
      ),
    );
  }
}
