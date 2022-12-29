import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:store_aplication/common/utils.dart';
import 'package:store_aplication/data/product.dart';
import 'package:store_aplication/theme.dart';
import 'package:store_aplication/ui/widgets/image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(
                  imageUrl: product.imageUrl, borderRadius: null),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(product.previousPrice.withPriceLable,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .apply(
                                      decoration: TextDecoration.lineThrough,
                                    )),
                            Text(product.price.withPriceLable),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24,),
                    Text(
                        "این کتکتونی بسیار زیبا میباشد که دوام زیادی داشته و هیچ گونه اثر مخربی به پاهای فرد ندارد")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
