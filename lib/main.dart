import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainScreen.dart';
import 'onBoardingScreen.dart';
import 'presentation/calendar/view/config.dart';
import 'presentation/calendar/view/notificationsData.dart';
import 'presentation/my_matches/view/MyMathesPage.dart';

late SharedPreferences preferencies;
final remoteCongig = FirebaseRemoteConfig.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await remoteCongig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));
  await NotificationServiceFb().activate();
  await isCallStars();
  preferencies = await SharedPreferences.getInstance();
  bool isOnBoarding = preferencies.getBool('onBoarding') ?? false;
  runApp(MyApp(isOnBoarding: isOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool isOnBoarding;

  const MyApp({super.key, required this.isOnBoarding});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isOnBoarding == true ? MyHomePage() : const OnBoardingScreen(),
    );
  }
}
