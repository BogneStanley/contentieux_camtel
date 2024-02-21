import 'dart:io';

import 'package:dio/dio.dart';

class ElasticsearchApi {
  Dio client = Dio();

  Future<Map<String, dynamic>> getContentieux() async {
    try {
      return (await client.get(
              "https://apisoutenance.stanleybogne.com/cumul_trafic*/_search?q=*&size=1000"))
          .data as Map<String, dynamic>;
    } catch (e) {
      return {
        "error": "Une erreur est survenu",
      };
    }
  }
}
