import 'package:dermacare_ai/controller/getStorage.dart';
import 'package:dermacare_ai/screen/HomePage/homePage.dart';
import 'package:dermacare_ai/screen/HomePage/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
      initState: (_) {},
      builder: (_) {
        return _.isLogin == true
            ? const HomePage(
                title: 'DermaCare AI',
              )
            : const WelcomePage();
      },
    );
  }
}
