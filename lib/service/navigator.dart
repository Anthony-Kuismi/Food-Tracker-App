import 'package:flutter/cupertino.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> push(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
  Future<void> pushReplace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
  void pop(){
    return navigatorKey.currentState!.pop();
  }
}