import 'package:flutter/material.dart';

mixin NavigatorManager {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context){
        return widget;
    },
    fullscreenDialog: true,
    settings: RouteSettings())
  );}

  Future<T?> navigateToNormalWidget<T>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>
    (MaterialPageRoute(
      builder: (context){
        return widget;
    },
    fullscreenDialog: true,
    settings: RouteSettings())
  );}
}