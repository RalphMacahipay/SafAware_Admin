import 'package:accounts/services/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is Admin Panel'),
      ),
      body: const Text('This is Web Home Page'),
    );
  }
}
