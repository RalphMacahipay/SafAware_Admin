import 'package:accounts/pages_thesis_app/mobile/add_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer' as devstool show log;

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  ChangeRouteToHome getValChangeRouteAllows = ChangeRouteToHome();
  bool? getVal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () async {
            // deleteCollection();
            // Navigator.of(context)
            //     .pushNamedAndRemoveUntil(loginPageRoute, (route) => false);
          },
        ),
      ),
      body: Column(
        children: const [
          Text("A verification link has been sent to your email"),
          Text("Not yet received?"),
          //   verifyButton,
          // backButton,
        ],
      ),
    );
  }
}
