import 'package:flutter/material.dart';
import 'package:flutter_login_whatapp/page/whatsapp_home.dart';
import 'package:flutter_login_whatapp/widgets/welcome_widget.dart';

import 'page/login_page.dart';
import 'page/pokemon/pokemon_screen.dart';
import 'page/shop/shop_screen.dart';
import 'theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter what\'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Column(
        children: [
          const WelcomeHeaderWidget(),
          GradientBtnWidget(
              width: 208,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PokemonPage();
                  },
                ));
              },
              child: const BtnTextWhiteWidget(text: 'Pokemon')),
          SizedBox(
            height: 16,
          ),
          GradientBtnWidget(
              width: 208,
              onTap: () {},
              child: const BtnTextWhiteWidget(text: 'Sign up')),
          const SizedBox(height: 16),
          GestureDetector(
            child: LoginBtnWidget(),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ));
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(StadiumBorder(
                      side: BorderSide(
                    //设置 界面效果
                    style: BorderStyle.solid,
                    color: Color(0xffFF7F24),
                  ))),
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xffEDFCF5))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return WhatsAppHome();
                  },
                ));
              },
              child: Text(
                'what\'app',
                style: TextStyle(color: Colors.black),
              )),
          const Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 18,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 54),
          Row(
            children: <Widget>[
              Spacer(),
              LineWidget(),
              LoginTypeIconWidget(
                icon: 'assets/icons/logo_ins.png',
                title: 'shop',
                click: () {
                  print('object');

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ShopPage();
                    },
                  ));
                },
              ),
              LoginTypeIconWidget(
                icon: 'assets/icons/logo_fb.png',
                title: '456',
                click: () {},
              ),
              LoginTypeIconWidget(
                icon: 'assets/icons/logo_twitter.png',
                title: '789',
                click: () {},
              ),
              LineWidget(),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
