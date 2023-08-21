import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../widget/fill_button_widget.dart';
import 'no_internet_controller.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: hp(6),
          ),
          Image.asset(
            "assets/icons/no_internet.png",
          ),
          Text(
            "Ooops!",
            textAlign: TextAlign.center,
            style: smallTitleTextStyle,
          ),
          SizedBox(
            height: hp(2),
          ),
          Text(
            "No Internet Connection Found\n Check your connection",
            textAlign: TextAlign.center,
            style: textRegularStyle,
          ),
          SizedBox(
            height: hp(4),
          ),
          GetBuilder<NoInternetController>(
            init: NoInternetController(),
            initState: (_) {},
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: wp(30),
                ),
                child: FillButtonWidget(
                    height: hp(5),
                    text: "Try again",
                    textstyle: textBodyStyle.copyWith(color: Colors.white),
                    onPressed: () {
                      controller.refreshPage(context);
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
