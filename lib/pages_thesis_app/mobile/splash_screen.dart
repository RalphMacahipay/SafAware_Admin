import 'dart:async';
import 'package:accounts/pages_thesis_app/mobile/email_verify.dart';
import 'package:accounts/pages_thesis_app/mobile/home_page.dart';
import 'package:accounts/pages_thesis_app/mobile/login_page.dart';
import 'package:accounts/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => checkerBool());
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void checkerBool() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? chosePage()
      : Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitCircle(
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Loading...',
                  style: GoogleFonts.lato(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );

  chosePage() {
    final user = AuthService.firebase().currentUser;
    if (user != null) {
      if (user.isEmailVerified) {
        timer?.cancel();
        return HomePage();
      } else {
        timer?.cancel();
        return const VerifyEmailPage();
      }
    } else {
      timer?.cancel();
      return const LoginPage();
    }
  }
}

class DefaultSplashView {
  Widget defaultSplash() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitCircle(
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Loading...',
              style: GoogleFonts.lato(
                fontStyle: FontStyle.normal,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
