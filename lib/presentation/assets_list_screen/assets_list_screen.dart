import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_task/api/api_service.dart';
import 'package:test_task/presentation/_utils/color_to_symbol_converter.dart';
import 'package:test_task/presentation/assets_list_screen/price_formatter.dart';
import 'package:utils/utils_dart.dart';

import 'assets_list_screen_wm.dart';

class AssetsListScreenWidget extends ElementaryWidget<AssetsListScreenWm>
    with LoggerMixin {
  AssetsListScreenWidget({super.key})
      : super((context) => AssetsListScreenWm());

  @override
  Widget build(wm, context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return PagedListView<int, Asset>(
            pagingController: wm.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Asset>(
              itemBuilder: (context, item, index) {
                return AssetListItem(
                  asset: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AssetListItem extends StatelessWidget {
  final Asset asset;

  const AssetListItem({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Colored circle avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorToSymbolConverter().getColorForSymbol(asset.symbol),
            ),
          ),
          const SizedBox(width: 16),
          // Symbol
          Text(
            asset.symbol,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          // Price
          Text(
            PriceFormatter.formatPrice(asset.priceUsd),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
