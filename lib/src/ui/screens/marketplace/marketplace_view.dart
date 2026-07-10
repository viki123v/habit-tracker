import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/database.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/domain/repostiories/marketplace_repository.dart';
import 'package:habit_tracker/src/ui/core/shared/home_bottom_navbar.dart';
import 'package:habit_tracker/src/ui/core/shared/home_navbar.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_item.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_viewmodel.dart';
import 'package:provider/provider.dart';

class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MarketplaceViewModel(
        MarketplaceRepository(
          ctx.read<AppDatabase>().marketplaceDao,
          ctx.read<ActiveUserDao>(),
        ),
      ),
      child: const _MarketplaceViewContent(),
    );
  }
}

class _MarketplaceViewContent extends StatefulWidget {
  const _MarketplaceViewContent();

  @override
  State<_MarketplaceViewContent> createState() =>
      _MarketplaceViewContentState();
}

class _MarketplaceViewContentState extends State<_MarketplaceViewContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MarketplaceViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final activeUserRepository = context.watch<ActiveUserRepository>();

    return Scaffold(
      appBar: HomeNavbar(
        activeUser: activeUserRepository.getActiveUser(),
        title: 'Marketplace',
      ),
      body: const _MarketplaceBody(),
    );
  }
}

class _MarketplaceBody extends StatelessWidget {
  const _MarketplaceBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MarketplaceViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: viewModel.load,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth >= 640 ? 3 : 2;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              Spacings.spacious,
              Spacings.loose,
              Spacings.spacious,
              Spacings.section,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Spacings.relaxed,
              children: [
                _SectionTitle(
                  title: 'Featured Items',
                  actionLabel: 'View All',
                  onAction: () => viewModel.selectCategory(null),
                ),
                SizedBox(
                  height: 172,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.featuredItems.length,
                    separatorBuilder: (_, _) => SizedBox(width: Spacings.cozy),
                    itemBuilder: (context, index) => _FeaturedItemCard(
                      item: viewModel.featuredItems[index],
                      owned: viewModel.isOwned(viewModel.featuredItems[index]),
                      buying: viewModel.isBuying(
                        viewModel.featuredItems[index],
                      ),
                      onBuy: () => _confirmPurchase(
                        context,
                        viewModel.featuredItems[index],
                      ),
                    ),
                  ),
                ),
                _CategoryFilters(viewModel: viewModel),
                const _CompactLabel('All Items'),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.visibleItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: Spacings.cozy,
                    mainAxisSpacing: Spacings.cozy,
                    childAspectRatio: 0.64,
                  ),
                  itemBuilder: (context, index) {
                    final item = viewModel.visibleItems[index];
                    return _MarketplaceItemCard(
                      item: item,
                      owned: viewModel.isOwned(item),
                      buying: viewModel.isBuying(item),
                      onBuy: () => _confirmPurchase(context, item),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        TextButton(onPressed: onAction, child: Text(actionLabel)),
      ],
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters({required this.viewModel});

  final MarketplaceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final filters =
        <({String label, IconData icon, MarketplaceCategory? value})>[
          (label: 'All', icon: Icons.auto_awesome_outlined, value: null),
          (
            label: 'Avatar',
            icon: Icons.person_outline,
            value: MarketplaceCategory.avatar,
          ),
          (
            label: 'Themes',
            icon: Icons.palette_outlined,
            value: MarketplaceCategory.themes,
          ),
          (
            label: 'Long-term',
            icon: Icons.emoji_events_outlined,
            value: MarketplaceCategory.longTerm,
          ),
        ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: Spacings.tight,
        children: filters.map((filter) {
          final selected = viewModel.selectedCategory == filter.value;
          return ChoiceChip(
            selected: selected,
            onSelected: (_) => viewModel.selectCategory(filter.value),
            avatar: Icon(
              filter.icon,
              size: 16,
              color: selected ? Colors.white : ColorPalette.neutral,
            ),
            label: Text(filter.label),
            labelStyle: TextStyle(
              color: selected ? Colors.white : ColorPalette.neutral,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: ColorPalette.primary,
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade300),
          );
        }).toList(),
      ),
    );
  }
}

class _FeaturedItemCard extends StatelessWidget {
  const _FeaturedItemCard({
    required this.item,
    required this.owned,
    required this.buying,
    required this.onBuy,
  });

  final MarketplaceItem item;
  final bool owned;
  final bool buying;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.imageAsset, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(20),
                    Colors.black.withAlpha(190),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Spacings.cozy),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _RarityBadge(rarity: item.rarity),
                  SizedBox(height: Spacings.extraTight),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: Spacings.hairline),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Unlock your next milestone',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: rawProperties.textSize.size100.toDouble(),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacings.tight),
                      _PricePill(price: item.price, dark: true),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: Spacings.tight,
              right: Spacings.tight,
              child: _BuyButton(
                owned: owned,
                buying: buying,
                compact: true,
                onBuy: onBuy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarketplaceItemCard extends StatelessWidget {
  const _MarketplaceItemCard({
    required this.item,
    required this.owned,
    required this.buying,
    required this.onBuy,
  });

  final MarketplaceItem item;
  final bool owned;
  final bool buying;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(item.imageAsset, fit: BoxFit.cover),
                Positioned(
                  top: Spacings.tight,
                  left: Spacings.tight,
                  child: _RarityBadge(rarity: item.rarity),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.all(Spacings.cozy),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CompactLabel(item.category.label),
                  SizedBox(height: Spacings.extraTight),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(child: _PricePill(price: item.price)),
                      SizedBox(width: Spacings.tight),
                      _BuyButton(owned: owned, buying: buying, onBuy: onBuy),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RarityBadge extends StatelessWidget {
  const _RarityBadge({required this.rarity});

  final MarketplaceRarity rarity;

  @override
  Widget build(BuildContext context) {
    final color = switch (rarity) {
      MarketplaceRarity.common => ColorPalette.neutral,
      MarketplaceRarity.rare => ColorPalette.info,
      MarketplaceRarity.epic => ColorPalette.secondary,
      MarketplaceRarity.legendary => ColorPalette.warning,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: color, borderRadius: BorderSizings.xl),
      child: Text(
        rarity.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CompactLabel extends StatelessWidget {
  const _CompactLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: ColorPalette.neutral,
        fontSize: rawProperties.textSize.size100.toDouble(),
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
    );
  }
}

class _PricePill extends StatelessWidget {
  const _PricePill({required this.price, this.dark = false});

  final int price;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.toll,
          size: 15,
          color: dark ? Colors.white : ColorPalette.supportColor3,
        ),
        SizedBox(width: Spacings.hairline),
        Flexible(
          child: Text(
            price.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: rawProperties.textSize.size200.toDouble(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BuyButton extends StatelessWidget {
  const _BuyButton({
    required this.owned,
    required this.buying,
    required this.onBuy,
    this.compact = false,
  });

  final bool owned;
  final bool buying;
  final bool compact;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final child = buying
        ? const SizedBox.square(
            dimension: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(owned ? 'Owned' : 'Buy');

    return FilledButton(
      onPressed: owned || buying ? null : onBuy,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 12,
          vertical: compact ? 6 : 8,
        ),
        minimumSize: compact ? const Size(58, 30) : const Size(64, 34),
      ),
      child: child,
    );
  }
}

Future<void> _confirmPurchase(
  BuildContext context,
  MarketplaceItem item,
) async {
  final viewModel = context.read<MarketplaceViewModel>();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Buy ${item.title}?'),
      content: Text(
        'Spend ${item.price} points on this '
        '${item.category.label.toLowerCase()} item?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Buy'),
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) return;

  final result = await viewModel.buy(item);
  if (!context.mounted) return;

  final message = switch (result) {
    PurchaseResult.success => '${item.title} added to your collection.',
    PurchaseResult.alreadyOwned => 'You already own ${item.title}.',
    PurchaseResult.insufficientPoints =>
      'You need more points for ${item.title}.',
    PurchaseResult.noActiveUser => 'Log in before buying marketplace items.',
    PurchaseResult.failed => 'Could not complete the purchase.',
  };

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
