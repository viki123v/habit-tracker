import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/dao/marketplace_dao.dart';
import 'package:habit_tracker/src/data/models/purchased_marketplace_item.dart';

enum PurchaseResult {
  success,
  alreadyOwned,
  insufficientPoints,
  noActiveUser,
  failed,
}

class MarketplaceRepository {
  MarketplaceRepository(this._marketplaceDao, this._activeUserDao);

  final MarketplaceDao _marketplaceDao;
  final ActiveUserDao _activeUserDao;

  Future<Set<String>> getOwnedItemIds() async {
    final items = await _marketplaceDao.getPurchasedItems();
    return items.map((item) => item.itemId).toSet();
  }

  Future<PurchaseResult> purchaseItem({
    required String itemId,
    required int price,
  }) async {
    final existingPurchase = await _marketplaceDao.getPurchasedItem(itemId);
    if (existingPurchase != null) return PurchaseResult.alreadyOwned;

    final user = await _activeUserDao.getActiveUser();
    if (user == null) return PurchaseResult.noActiveUser;
    if (user.points < price) return PurchaseResult.insufficientPoints;

    var deductedPoints = false;
    try {
      await _activeUserDao.addPoints(-price);
      deductedPoints = true;
      await _marketplaceDao.savePurchasedItem(
        PurchasedMarketplaceItem(itemId: itemId, purchasedAt: DateTime.now()),
      );
      return PurchaseResult.success;
    } catch (_) {
      if (deductedPoints) await _activeUserDao.addPoints(price);
      return PurchaseResult.failed;
    }
  }
}
