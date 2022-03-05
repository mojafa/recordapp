import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record_app/screens/HomeScreen.dart';

class ImageSplash extends StatefulWidget {
  const ImageSplash({Key key}) : super(key: key);

  @override
  State<ImageSplash> createState() => _ImageSplashState();
}

class _ImageSplashState extends State<ImageSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset(
          'assets/images/splash.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
