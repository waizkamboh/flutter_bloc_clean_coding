


import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_coding/config/routes/routes_name.dart';
import 'package:flutter_bloc_clean_coding/views/splash/splash_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context)=> SplashScreen());

      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
              child: Text('no route generated'),
            ),
          );
        });
    }
  }
}