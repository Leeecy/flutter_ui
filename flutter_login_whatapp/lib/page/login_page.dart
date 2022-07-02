import 'package:flutter/material.dart';

import '../widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset('assets/images/bg_login_header.png'),
          Column(
            children: <Widget>[
              SizedBox(height: 200),
              ClipPath(
                child: LoginBodyWidget(),
                clipper: LoginClipper(),
              ),
            ],
          ),
          const Positioned(
            top: 64,
            left: 28,
            child: BackIcon(),
          )
        ],
      ),
    );
  }
}
