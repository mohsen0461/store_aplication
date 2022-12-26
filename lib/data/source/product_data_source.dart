
import 'package:store_aplication/data/common/http_response_validator.dart';
import 'package:store_aplication/data/product.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);

  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource with HttpResponseValidator implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final Response response = await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final List<ProductEntity> products = [];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final Response response =
        await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final List<ProductEntity> products = [];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }


}
