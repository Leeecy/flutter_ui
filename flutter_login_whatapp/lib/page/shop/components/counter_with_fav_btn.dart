import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_colors.dart';

class CounterWithFavBtn extends StatefulWidget {
  final int totalNums;
  final VoidCallback sunCall;
  final VoidCallback addCall;
  const CounterWithFavBtn({
    Key? key, required this.totalNums, required this.sunCall, required this.addCall,
  }) : super(key: key);

  @override
  State<CounterWithFavBtn> createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            buildOutlineButton(
              icon: Icons.remove,
              press: () {
                widget.sunCall();
                // if (numOfItems > 1) {
                //   setState(() {
                //     numOfItems--;
                //   });
                // }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Text(
                // if our item is less  then 10 then  it shows 01 02 like that
                widget.totalNums.toString().padLeft(2, "0"),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            buildOutlineButton(
                icon: Icons.add,
                press: () {
                  widget.addCall();
                  // setState(() {
                  //   numOfItems++;
                  // });
                }),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Color(0xFFFF6464),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset("assets/icons/heart.svg"),
        )
      ],
    );
  }
}

SizedBox buildOutlineButton({required IconData icon, required Function press}) {
  return SizedBox(
    width: 40,
    height: 32,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      onPressed: () {
        press();
      },
      child: Icon(icon),
    ),
  );
}
