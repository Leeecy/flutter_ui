import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login_whatapp/page/shop/shop_detail_screen.dart';
import '../../../models/shop/product.dart';
import '../../../theme/app_colors.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Women",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),

        // Expanded(
        //   child: GridView.custom(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        //     childrenDelegate: SliverChildBuilderDelegate(
        //       (BuildContext ctx, int index) {
        //         return Container(
        //           color: Color.fromARGB(
        //               Random().nextInt(256),
        //               Random().nextInt(256),
        //               Random().nextInt(256),
        //               Random().nextInt(256)),
        //         );
        //       },
        //     ),
        //   ),
        // ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
                // padding: const EdgeInsets.all(20),
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  return ItemCard(
                      product: products[index],
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopDetailsScreen(
                                      product: products[index],
                                    )));
                      });
                }),
          ),
        ),
      ],
    );
  }
}
