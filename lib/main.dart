import 'package:accounts/pages_thesis_app/mobile/add_numbers.dart';
import 'package:accounts/pages_thesis_app/mobile/added_contact_person.dart';
import 'package:accounts/pages_thesis_app/mobile/email_verify.dart';
import 'package:accounts/pages_thesis_app/mobile/home_page.dart';
import 'package:accounts/pages_thesis_app/mobile/login_page.dart';
import 'package:accounts/pages_thesis_app/mobile/register_page.dart';
import 'package:accounts/pages_thesis_app/mobile/splash_screen.dart';
import 'package:accounts/pages_thesis_app/mobile/tester_widget.dart';
import 'package:accounts/pages_thesis_app/web/web_home.dart';
import 'package:accounts/routes/route_pages.dart';
import 'package:accounts/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import 'pages_thesis_app/mobile/alarm_service/alarm_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final currentWith = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentWith <= 1600
          ? const InitializerPageMobile()
          : const InitializePageWeb(),
      routes: {
        registerPageRoute: (context) => const RegisterPage(),
        homePageRoute: (context) => HomePage(),
        //TODO FIXED DAPAT CODE NALANG SA FINALS SA EMAIL VERIFICATION

        verifyEmailRoute: (context) => const VerifyEmailPage(),
        loginPageRoute: (context) => const LoginPage(),
        splashRoute: (context) => const SplashView(),
        addNumRoute: (context) => const NumberForContact(),
        addCOntactPersonRoute: (context) => const ContactPersonAdded(),
        alarmScreenRoute: (context) => const CountdownPage(),
      },
    );
  }
}

class InitializerPageMobile extends StatefulWidget {
  const InitializerPageMobile({Key? key}) : super(key: key);

  @override
  State<InitializerPageMobile> createState() => _InitializerPageMobileState();
}

class _InitializerPageMobileState extends State<InitializerPageMobile> {
  @override
  Widget build(BuildContext context) {
    // Para ma store yung user (no need na mag login pag verified na ang email)

    return FutureBuilder(
      // initializeApp (isang beses lang dapat gawin hindi  per widget)
      future: AuthService.firebase().initialize(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const SplashView();

          default:
            return DefaultSplashView().defaultSplash();
        }
      }),
    );
  }
}

class InitializePageWeb extends StatefulWidget {
  const InitializePageWeb({super.key});

  @override
  State<InitializePageWeb> createState() => _InitializePageWebState();
}

class _InitializePageWebState extends State<InitializePageWeb> {
  @override
  Widget build(BuildContext context) {
    return const WebHomePage();
  }
}
