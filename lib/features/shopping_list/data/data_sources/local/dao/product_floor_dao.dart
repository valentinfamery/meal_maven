import 'package:floor/floor.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM Product')
  Future<List<Product>> getAllProductFloor();

  @Query('SELECT * FROM Product WHERE barcodeId = :barcodeId')
  Future<Product?> getProductFloorById(int barcodeId);

  @insert
  Future<void> insertProductFloor(Product productFloor);
}
