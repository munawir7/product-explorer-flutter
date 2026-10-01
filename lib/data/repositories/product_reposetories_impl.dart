import 'package:task/domain/repositories/product_repositories.dart';

import '../../domain/entities/product.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  List<Product> getProducts() {
    return localDataSource.products;
  }
}