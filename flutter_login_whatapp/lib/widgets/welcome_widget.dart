import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_size.dart';
import '../theme/app_style.dart';

/// 登录方式图标
class LoginTypeIconWidget extends StatelessWidget {
  const LoginTypeIconWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.click,
  }) : super(key: key);
  final String icon;
  final String title;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Column(
        children: [
          Text(title,style: TextStyle(fontSize: 24),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              icon,
              width: 22,
              height: 22,
            ),
          ),
        ],
      ),
    );
  }
}

/// 横线
class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Divider(color: kTextColor),
    );
  }
}

/// 登录按钮
class LoginBtnWidget extends StatelessWidget {
  const LoginBtnWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 208,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kBtnShadow,
        borderRadius: BorderRadius.circular(kBtnRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        'Login',
        style: kBtnTextStyle,
      ),
    );
  }
}

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg_welcome_header.png',
          height: 400,
        ),
        Positioned(
          top: 144,
          left: 40,
          child: Column(
            children: [
              AppIconWidget(),
              SizedBox(height: 8),
              Text(
                'Sour',
                style: kTitleTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'Best drink\nreceipes',
                style: kBodyTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// App Icon
class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIconBoxSize,
      height: kIconBoxSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/icons/app_icon.png',
        width: 24,
        height: 32,
      ),
    );
  }
}

/// 白色按钮文字
class BtnTextWhiteWidget extends StatelessWidget {
  const BtnTextWhiteWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBtnTextStyle.copyWith(
        color: Colors.black,
      ),
    );
  }
}

class GradientBtnWidget extends StatelessWidget {
  const GradientBtnWidget(
      {Key? key, required this.width, required this.child, required this.onTap})
      : super(key: key);

  final double width;
  final Widget child;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 48,
        decoration: BoxDecoration(
          gradient: kBtnLinearGradient,
          boxShadow: kBtnShadow,
          borderRadius: BorderRadius.circular(kBtnRadius),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
