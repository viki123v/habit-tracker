enum MarketplaceCategory { avatar, themes, longTerm }

enum MarketplaceRarity { common, rare, epic, legendary }

class MarketplaceItem {
  const MarketplaceItem({
    required this.id,
    required this.title,
    required this.category,
    required this.rarity,
    required this.price,
    required this.imageAsset,
    this.featured = false,
  });

  final String id;
  final String title;
  final MarketplaceCategory category;
  final MarketplaceRarity rarity;
  final int price;
  final String imageAsset;
  final bool featured;
}

extension MarketplaceCategoryLabel on MarketplaceCategory {
  String get label {
    switch (this) {
      case MarketplaceCategory.avatar:
        return 'Avatar';
      case MarketplaceCategory.themes:
        return 'Themes';
      case MarketplaceCategory.longTerm:
        return 'Long-term';
    }
  }
}

extension MarketplaceRarityLabel on MarketplaceRarity {
  String get label {
    switch (this) {
      case MarketplaceRarity.common:
        return 'Common';
      case MarketplaceRarity.rare:
        return 'Rare';
      case MarketplaceRarity.epic:
        return 'Epic';
      case MarketplaceRarity.legendary:
        return 'Legendary';
    }
  }
}
