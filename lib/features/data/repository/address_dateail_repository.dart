import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:search_me_test/features/data/models/address_detail_model.dart';
import 'package:search_me_test/features/data/models/app_lat_long.dart';

class AddressDetailRepository {
  Future<AddressDetailModel> getAddressDetail(AppLatLong latLong) async {
    String mapApiKey = "fa56eabe-fd5b-4269-ac5a-da0de01a002a";
    try {
      Map<String, String> queryParams = {
        'apikey': mapApiKey,
        'geocode': "${latLong.lat},${latLong.long}",
        'lang': 'uz',
        'format': 'json',
        'results': '1'
      };
      Dio yandexDio = Dio();
      var response = await yandexDio.get("https://geocode-maps.yandex.ru/1.x/",
          queryParameters: queryParams);
      return AddressDetailModel.fromJson(json.decode(response.data));
    } catch (e) {
      print("Error $e");
    }
    return AddressDetailRepository().getAddressDetail(latLong);
  }
}
