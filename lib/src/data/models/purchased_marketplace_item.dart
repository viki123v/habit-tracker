import 'package:floor/floor.dart';

@entity
class PurchasedMarketplaceItem {
  @primaryKey
  final String itemId;
  final DateTime purchasedAt;

  PurchasedMarketplaceItem({
    required this.itemId,
    required this.purchasedAt,
  });
}
