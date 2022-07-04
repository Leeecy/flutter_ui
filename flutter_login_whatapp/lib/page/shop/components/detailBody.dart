import 'package:flutter/material.dart';
import 'package:flutter_login_whatapp/page/shop/components/product_title_with_image.dart';
import '../../../models/shop/product.dart';
import '../../../theme/app_colors.dart';
import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
class DetailBody extends StatefulWidget {
  final Product product;
  const DetailBody({Key? key, required this.product}) : super(key: key);
  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: widget.product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: widget.product,),
                      SizedBox(height: kDefaultPaddin / 2),
                      CounterWithFavBtn(),
                      SizedBox(height: kDefaultPaddin / 2),
                      AddToCart(product: widget.product),
                    ],
                  ),
                ),

                ProductTitleWithImage(product: widget.product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget{
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
