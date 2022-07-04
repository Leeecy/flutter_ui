import 'package:flutter/material.dart';
import 'package:flutter_login_whatapp/page/shop/shop_detail_screen.dart';
import '../../../models/shop/product.dart';
import '../../../theme/app_colors.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
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
        Categories(onClick: (int index) {
          setState((){
            currentIndex = index;
          });
        },),


        Container(child: contents(currentIndex)),


      ],
    );
  }

  Widget? contents(int currentIndex){
    switch(currentIndex){
      case 0:{
        return Expanded(
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
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopDetailsScreen(
                              product: products[index],
                            ),
                          ));
                    },
                    product: products[index],
                  );
                }),
          ),
        );
      }

      case 1:{
        return Text('3333');
      }

      case 2:{
        return Text('44444');
      }

      case 3:{
        return Text('55555');
      }
    }
  }
}


