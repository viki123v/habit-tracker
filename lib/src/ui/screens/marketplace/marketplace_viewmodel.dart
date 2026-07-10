import 'package:flutter/foundation.dart';
import 'package:habit_tracker/src/domain/repostiories/marketplace_repository.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_catalog.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_item.dart';

class MarketplaceViewModel extends ChangeNotifier {
  MarketplaceViewModel(this._marketplaceRepository);

  final MarketplaceRepository _marketplaceRepository;

  bool _isLoading = true;
  MarketplaceCategory? _selectedCategory;
  Set<String> _ownedItemIds = {};
  String? _buyingItemId;

  bool get isLoading => _isLoading;
  MarketplaceCategory? get selectedCategory => _selectedCategory;
  Set<String> get ownedItemIds => _ownedItemIds;
  String? get buyingItemId => _buyingItemId;

  List<MarketplaceItem> get featuredItems =>
      marketplaceCatalog.where((item) => item.featured).toList();

  List<MarketplaceItem> get visibleItems {
    if (_selectedCategory == null) return marketplaceCatalog;
    return marketplaceCatalog
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _ownedItemIds = await _marketplaceRepository.getOwnedItemIds();
    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(MarketplaceCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  bool isOwned(MarketplaceItem item) => _ownedItemIds.contains(item.id);

  bool isBuying(MarketplaceItem item) => _buyingItemId == item.id;

  Future<PurchaseResult> buy(MarketplaceItem item) async {
    if (_buyingItemId != null) return PurchaseResult.failed;
    if (isOwned(item)) return PurchaseResult.alreadyOwned;

    _buyingItemId = item.id;
    notifyListeners();

    final result = await _marketplaceRepository.purchaseItem(
      itemId: item.id,
      price: item.price,
    );

    if (result == PurchaseResult.success ||
        result == PurchaseResult.alreadyOwned) {
      _ownedItemIds = await _marketplaceRepository.getOwnedItemIds();
    }

    _buyingItemId = null;
    notifyListeners();
    return result;
  }
}
