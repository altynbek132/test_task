import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.freezed.dart';
part 'api_service.g.dart';

const baseUrl = "https://api.coincap.io/v2";

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
// ====================================================== admin ===================================================== //
  @GET('/assets')
  Future<GetAssetPaginated> getAssets({
    @Query('offset') int? offset,
    @Query('limit') int limit = 15,
  });
}

@freezed
class Asset with _$Asset {
  factory Asset({
    required String symbol,
    required String priceUsd,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

@freezed
class GetAssetPaginated with _$GetAssetPaginated {
  factory GetAssetPaginated({
    required List<Asset> data,
    required int timestamp,
  }) = _GetAssetPaginated;

  factory GetAssetPaginated.fromJson(Map<String, dynamic> json) =>
      _$GetAssetPaginatedFromJson(json);
}
