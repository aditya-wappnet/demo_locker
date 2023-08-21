import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/textStyle.dart';

class NoInternetController extends GetxController {
  NoInternetController();
  var isinternetConnected = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkInternetConnectionOnAppStart();
    checkInternetConnectionThroughoutApp();
  }

  //check internet connectivity when application start
  Future<void> checkInternetConnectionOnAppStart() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isinternetConnected.value = false;
    } else {
      isinternetConnected.value = true;
    }
  }

//listen to internet while application is in foreground
  void checkInternetConnectionThroughoutApp() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        isinternetConnected.value = false;
      } else {
        isinternetConnected.value = true;
      }
    });
  }

  // Add a function to refresh the page and try again

  void refreshPage(context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      isinternetConnected.value = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "No connection found.",
          textAlign: TextAlign.justify,
          style: textRegularStyle.copyWith(
              fontWeight: FontWeight.normal, color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        padding:
            const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 10),
        margin: const EdgeInsets.all(15),
      ));
    }
  }
}
