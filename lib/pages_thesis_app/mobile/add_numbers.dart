import 'package:accounts/pages_thesis_app/mobile/register_page.dart';
import 'package:accounts/pages_thesis_app/mobile/tester_widget.dart';
import 'package:accounts/routes/route_pages.dart';
import 'package:accounts/sound_image_code/sound_images_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:developer' as devstool show log;

class NumberForContact extends StatefulWidget {
  const NumberForContact({super.key});

  @override
  State<NumberForContact> createState() => _NumberForContactState();
}

class _NumberForContactState extends State<NumberForContact> {
  ChangeRouteToHome modelChangeRoute = ChangeRouteToHome();
  // bool? ischangeRouteAllow = false;
  bool? getVal;

  @override
  void initState() {
    modelChangeRoute.isChangRouteAllowed = false;
    getVal = modelChangeRoute.isChangRouteAllowed;

    devstool.log("The value of isChangeRouteAllow is $getVal");
    //  isChangeRouteAllow();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  isChangeRouteAllow() {
    setState(() {
      modelChangeRoute.isChangRouteAllowed = true;
      getVal = modelChangeRoute.isChangRouteAllowed!;
      devstool.log("The value of isChangeRouteAllow is $getVal");
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWith = MediaQuery.of(context).size.width;
    final maxHeigth = MediaQuery.of(context).size.height;

    final iconPerson = SvgPicture.asset(
      personIcon,
      height: 88,
      width: 88,
    );

    const textDisplay = Text("Add Contacts");

    final inputName = Container(
      decoration: BoxDecoration(
        border: Border.all(width: .5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Enter Your Number",
            border: InputBorder.none,
          ),
        ),
      ),
    );

    final inputContact = Container(
      decoration: BoxDecoration(
          border: Border.all(width: .5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Enter Contact Person",
            border: InputBorder.none,
          ),
        ),
      ),
    );

    final continueBTN = ElevatedButton(
      onPressed: () {
        ChangeRouteToHome modelChangeRoute = ChangeRouteToHome();

        devstool.log("This is the value of isChangRouteAllooowed is $getVal");
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil(addNumRoute, (route) => false);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TestWidget()));
      },
      child: const Text("Continue"),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () async {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerPageRoute, (route) => false);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: currentWith,
              maxHeight: maxHeigth,
            ),
            child: Container(
              height: 630,
              width: 300,
              decoration: BoxDecoration(
                color: HexColor("#BFC9FF").withOpacity(.6),
                borderRadius: BorderRadius.circular(74),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconPerson,
                  textDisplay,
                  inputName,
                  inputContact,
                  continueBTN,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeRouteToHome {
  bool? isChangRouteAllowed;

  ChangeRouteToHome({
    this.isChangRouteAllowed,
  });
}
