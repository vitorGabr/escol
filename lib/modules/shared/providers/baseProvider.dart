import 'dart:io';

import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:http/http.dart';

abstract class BaseProvider {

  final String url;
  final String token;
  
  BaseProvider(this.url, {this.token});

  Future<ResponseDefaultModel<List<T>>> getList<T>(
    String route,
    List<T> Function(String responseBody) callback
    ) async {
    var result = ResponseDefaultModel<List<T>>();

     try {
     
      final response = await get(route,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (response.statusCode == 200) {

        result
         ..data = callback(response.body)
         ..isSuccess = true;

      } else {
        result
         ..isSuccess = false
         ..error = response
         ..errorMessage = response.statusCode.toString() + "\n" + response.reasonPhrase + "\n" + response.reasonPhrase;
      }
    } on Exception catch (e) {
      result
       ..error = e
       ..errorMessage = e.toString()
       ..isSuccess = false;

    }

    return result;

  }

  Future<ResponseDefaultModel<T>> getItem<T>(
    String route, T Function(String responseBody) callback) async {
    
    var result = (ResponseDefaultModel<T>()
      ..isSuccess = false
    );
    

    try {
       //TODO: verificar se tem conexao
      // var resultConnection = await this.checkConnectionAsync();

      // if (!resultConnection.isSuccess) {
      //   result
      //    ..error = resultConnection.error
      //    ..errorMessage = resultConnection.errorMessage;
      //   return result;
      // }

      final response = await get(route,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (response.statusCode == 200) {
        try {
          result
           ..data = callback(response.body)
           ..isSuccess = true;
        } catch (e) {
          result
           ..isSuccess = false
           ..errorMessage = e.toString();
        }
      } else {
        result
         ..error = response
         ..errorMessage = response.statusCode.toString() + "\n" + response.reasonPhrase;
      }
    } on Exception catch (e) {
      result.error = e;

    }

    return result;
  }

}