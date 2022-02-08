import 'package:flutter/material.dart';
import 'package:on_boarding/cache.dart';
import 'package:on_boarding/home.dart';
import 'package:on_boarding/on_boarding.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await CacheHelper.init();
 //now its false
 bool showBoarding = CacheHelper.getData('showBoarding') ?? true;


late Widget widget =
      showBoarding == true||showBoarding == null ? OnBoardingScreen() : const HomeScreen();

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key,required this.startWidget}) : super(key: key);
  Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: startWidget,
    );
  }
}
