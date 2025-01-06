import 'dart:async';

import 'package:disposing/disposing_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:test_task/api/api_service.dart';
import 'package:utils/utils_dart.dart';
import 'package:utils/utils_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'assets_list_screen.dart';

part 'assets_list_screen_wm.g.dart';

class AssetsListScreenWm = AssetsListScreenWmBase with _$AssetsListScreenWm;

abstract class AssetsListScreenWmBase extends MobxWM<AssetsListScreenWidget>
    with Store, LoggerMixin {
  // INIT ---------------------------------------------------------------------

  AssetsListScreenWmBase({
    ApiService? apiService,
  }) : apiService = apiService ?? GetIt.instance.get();

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    pagingController.addPageRequestListener((offset) {
      _fetchPage(offset);
    });
  }

  // DI DEPENDENCIES ----------------------------------------------------------
  final ApiService apiService;

  // FIELDS -------------------------------------------------------------------
  late final pagingController = PagingController<int, Asset>(firstPageKey: 0)
    ..disposeOn(this);

  final _pageSize = 15;

  // PROXY --------------------------------------------------------------------

  // OBSERVABLES --------------------------------------------------------------

  // COMPUTED -----------------------------------------------------------------

  // STREAM REACTION ----------------------------------------------------------

  // ACTIONS ------------------------------------------------------------------

  Future<void> _fetchPage(int offset) async {
    try {
      final newItems = await apiService.getAssets(
        limit: _pageSize,
        offset: offset,
      );
      final isLastPage = newItems.data.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newItems.data);
      } else {
        final nextPageKey = offset + newItems.data.length;
        pagingController.appendPage(newItems.data, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      rethrow;
    }
  }
  // UI -----------------------------------------------------------------------

  // UTIL METHODS -------------------------------------------------------------

  @override
  void setupLoggers() {
    setupObservableLoggers(
      [
        () => '',
      ],
      logger,
    );
  }
}
