import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
    @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer(){
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

route() {
  Navigator.pushReplacementNamed(context, '/HomeScreen');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Lottie.asset(
            'assets/Animation/HomePage.json',
            fit: BoxFit.cover,
            animate: true,
          ),
        ),
      ),
    );
  }
}
