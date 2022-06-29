
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      title: 'Foodboss',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      getPages: Routes.routes,
      unknownRoute:
          GetPage(name: '/notfound', page: () => const SplashScreen()),
    );
  }
}

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    // GetPage(name: '/intro', page: () => const IntroScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    
  ];
}
