import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/shop/product.dart';
import '../../provider/provider_manager.dart';
import '../../theme/app_colors.dart';
import 'components/body.dart';
import 'components/detailBody.dart';

class ShopDetailsScreen extends StatelessWidget {
  final Product product;
  const ShopDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: DetailBody(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final count = ref.watch(counterController);
            return Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                      top:0,
                      // left: 20,
                      child: Text('$count',style: TextStyle(color: Colors.red,fontSize: 16),)),
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/cart.svg"),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },

        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
