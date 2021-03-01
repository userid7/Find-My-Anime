// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:splashscreen/splashscreen.dart';

// import 'pages/homepage.dart';

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         scaffoldBackgroundColor: Colors.orange,
// //         primaryColor: Colors.white,
// //       ),
// //       home: Homepage(),
// //     );
// //   }
// // }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//       seconds: 10,
//       navigateAfterSeconds: new AfterSplash(),
//       // title: new Text(
//       //   'Welcome In SplashScreen',
//       //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//       // ),
//       image: new Image.asset("assets\images\splash_Asset.png"),
//       backgroundColor: Colors.white,
//       styleTextUnderTheLoader: new TextStyle(),
//       photoSize: 100.0,
//       // onClick: () => print("Flutter Egypt"),
//       loaderColor: Colors.red,
//     );
//   }
// }

// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.orange,
//         primaryColor: Colors.white,
//       ),
//       home: Homepage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/homepage.dart';

void main() {
  runApp(ProviderScope(
      child: new MaterialApp(
    home: new MyApp(),
  )));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new AfterSplash(),
      // title: new Text(
      //   'Welcome In SplashScreen',
      //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      // ),
      image: new Image.asset('assets/images/splash_Asset.png'),
      photoSize: 130.0,
      backgroundColor: Colors.white,
      // useLoader: false,
      loaderColor: Colors.orange,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find My Anime',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orange,
        primaryColor: Colors.white,
      ),
      home: Homepage(),
    );
  }
}
