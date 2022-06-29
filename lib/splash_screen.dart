import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/todo_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  TodoController todoController = Get.put(TodoController(),permanent: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), (){
      todoController.getTodos();
      Get.offNamed('/home');
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Todo App'),),
    );
  }
}
