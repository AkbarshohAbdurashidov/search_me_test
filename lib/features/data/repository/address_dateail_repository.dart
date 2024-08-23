import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:search_me_test/features/data/models/address_detail_model.dart';
import 'package:search_me_test/features/data/models/app_lat_long.dart';

class AddressDetailRepository {
  Future<AddressDetailModel> getAddressDetail(AppLatLong latLong) async {
    String mapApiKey = "3359e609-2d19-4ff8-bb2b-d7309f9402f1";
    try {

      Map<String, dynamic> queryParams = {
        'apikey': mapApiKey,
        'geocode': "${latLong.lat},${latLong.long}",
        'lang': 'uz',
        'format': 'json',
        'results': '1'
      };
      Dio yandexDio = Dio();
      var response = await yandexDio.get("https://geocode-maps.yandex.ru/1.x",
          queryParameters: queryParams);
      return AddressDetailModel.fromJson(json.decode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }
}
