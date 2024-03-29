import 'dart:async';

import 'package:meal_maven/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:meal_maven/features/shopping_list/data/data_sources/remote/open_food_fact_product.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductFloorDao productFloorDao;

  ProductRepositoryImpl(this.productFloorDao);

  final apiOpenFoodFact = OpenFoodFactProduct();

  @override
  Future<List<Product>> searchProductByName(String name) async {
    final listSearchApiProduct = await apiOpenFoodFact.searchByName(name);

    List<Product> listSearchProductFinal = <Product>[];

    for (var element in listSearchApiProduct!) {
      final barcode = element!.barcode;
      final name = element.productName;
      final imageFrontUrl = element.imageFrontUrl;
      final quantity = element.quantity;

      listSearchProductFinal
          .add(Product(int.parse(barcode!), name, false, imageFrontUrl,false,quantity));

      print(element.barcode);
    }

    return listSearchProductFinal;
  }

  @override
  void insertProductInFloor(Product productEntity) async {
    final productFloor = Product(productEntity.barcodeId!, productEntity.name!,
        true, productEntity.imageFrontUrl,productEntity.buy,productEntity.quantity);
    await productFloorDao.insertProductFloor(productFloor);
  }

  @override
  Stream<List<Product>> getProductsSaved() {
    return productFloorDao.getAllProductFloor();
  }

  @override
  void deleteProductFloor(Product product) async {
    await productFloorDao.deleteProductFloor(product);
  }
}
