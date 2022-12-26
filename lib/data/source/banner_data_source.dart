import 'package:dio/dio.dart';
import 'package:store_aplication/data/banner.dart';
import 'package:store_aplication/data/common/http_response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAllBanner();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAllBanner() async {
    final Response response = await httpClient.get('banner/slider');
    validateResponse(response);

    final List<BannerEntity> banners = [];

    (response.data as List).forEach((jsonObject) {
      banners.add(BannerEntity.fromJson(jsonObject));
    });
    return banners;
  }
}
