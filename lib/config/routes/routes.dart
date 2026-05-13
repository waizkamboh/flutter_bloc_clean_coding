import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_coding/config/routes/routes_name.dart';
import '../../views/view.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context)=> SplashScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context)=> LoginScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context)=> HomeScreen());

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