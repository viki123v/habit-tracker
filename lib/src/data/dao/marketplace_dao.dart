import 'package:floor/floor.dart';
import 'package:habit_tracker/src/data/models/purchased_marketplace_item.dart';

@dao
abstract class MarketplaceDao {
  @Query('SELECT * FROM PurchasedMarketplaceItem')
  Future<List<PurchasedMarketplaceItem>> getPurchasedItems();

  @Query('SELECT * FROM PurchasedMarketplaceItem WHERE itemId = :itemId LIMIT 1')
  Future<PurchasedMarketplaceItem?> getPurchasedItem(String itemId);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> savePurchasedItem(PurchasedMarketplaceItem item);
}
