import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/responsive.dart';
import 'constant/textStyle.dart';
import 'managers/authentication_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> initializeSettings() async {
    final AuthenticationManager manager = Get.put(
      AuthenticationManager(),
      permanent: true,
    );
    manager.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else if (snapshot.connectionState == ConnectionState.done) {
            AuthenticationManager manager = Get.find();
            manager.navigation();
          }
        }
        return splashView(context);
      },
    );
  }
}

Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
  return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
}

Widget splashView(context) {
  return Scaffold(
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: hp(10),
          ),
          Placeholder(
            fallbackHeight: hp(25),
            fallbackWidth: wp(45),
          ),
          SizedBox(
            height: hp(5),
          ),
          Text(
            "Auth Module",
            textAlign: TextAlign.center,
            style: textMediumStyle.copyWith(
                fontSize: 28, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    ),
  );
}
