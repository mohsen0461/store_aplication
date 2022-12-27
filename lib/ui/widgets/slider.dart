import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_aplication/common/utils.dart';
import 'package:store_aplication/data/banner.dart';
import 'package:store_aplication/ui/widgets/image.dart';

class BannerSlider extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<BannerEntity> banners;
  BannerSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            physics: defaultScrollPhysics,
              controller: _pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) =>
                  _Slide(key: key, bannerEntity: banners[index])),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 20.0,
                    dotHeight: 3.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity bannerEntity;
  const _Slide({
    Key? key,
    required this.bannerEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        borderRadius: BorderRadius.circular(12),
        imageUrl: bannerEntity.imageUrl,
      ),
    );
  }
}
