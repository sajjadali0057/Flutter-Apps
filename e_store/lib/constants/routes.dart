
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
 static Routes instance = Routes();

  Future<dynamic> PushandRemoveUntil({required BuildContext context, required Widget widget}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
  Future<dynamic> Push ({ required BuildContext context, required Widget widget})
  {
    return Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
  }
  Future<dynamic> PushReplacement ({ required Widget widget, required context })
  {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>widget));
  }
}
