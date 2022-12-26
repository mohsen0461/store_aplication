
import 'package:store_aplication/data/common/http_client.dart';
import 'package:store_aplication/data/product.dart';
import 'package:store_aplication/data/source/product_data_source.dart';


final producrRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);

  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort) async =>
      await dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) async =>
      await dataSource.search(searchTerm);
}
