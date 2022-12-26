import 'package:store_aplication/data/banner.dart';
import 'package:store_aplication/data/common/http_client.dart';
import 'package:store_aplication/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getAllBanner();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<BannerEntity>> getAllBanner() => dataSource.getAllBanner();
}
