import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_aplication/common/utils.dart';
import 'package:store_aplication/data/product.dart';
import 'package:store_aplication/data/repo/baner_repository.dart';
import 'package:store_aplication/data/repo/product_repository.dart';
import 'package:store_aplication/ui/home/bloc/home_bloc.dart';
import 'package:store_aplication/ui/widgets/image.dart';
import 'package:store_aplication/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: producrRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: ((context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/nike_logo.png',
                            fit: BoxFit.fitHeight,
                            height: 24,
                          ),
                        );

                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );

                      case 3:
                        return _HorizontalProductList(
                          title: 'جدیدترین',
                          onTap: () {},
                          products: state.latestProducts,
                        );

                      case 4:
                        return _HorizontalProductList(
                          title: 'پربازدیدترین',
                          onTap: () {},
                          products: state.popularProducts,
                        );

                      default:
                        return Container();
                    }
                  });
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.exception.message),
                  ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(HomeRefresh());
                      },
                      child: const Text('تلاش دوباره'))
                ],
              );
            } else {
              throw Exception('state is not support');
            }
          }),
        ),
      )),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const _HorizontalProductList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(onPressed: onTap, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              physics: defaultScrollPhysics,
              padding: const EdgeInsets.only(left: 8, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: ((context, index) {
                final product = products[index];
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 176,
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 176,
                                height: 189,
                                child: ImageLoadingService(
                                    imageUrl: product.imageUrl,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Icon(
                                    CupertinoIcons.heart,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text( 
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                product.previousPrice.withPriceLable,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Text(product.price.withPriceLable),
                          )
                        ],
                      ),
                    ));
              })),
        )
      ],
    );
  }
}
