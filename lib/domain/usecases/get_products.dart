import 'package:task/domain/repositories/product_repositories.dart';

import '../entities/product.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  List<Product> call() {
    return repository.getProducts();
  }
}