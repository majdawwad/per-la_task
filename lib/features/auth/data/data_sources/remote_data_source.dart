import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<Unit> signUp(UserModel userModel);
  Future<UserModel> signIn(UserModel userModel);
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  RemoteDataSourceImplement({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<Unit> signUp(UserModel userDataModel) async {
    final Map<String, dynamic> body = {
      "full_name": userDataModel.fullname,
      "phone": userDataModel.phone,
      "password": userDataModel.password,
    };

    final reqBody = json.encode(body);

    final response = await client
        .post(Uri.parse("$baseUrlApi/test/register/"), body: reqBody, headers: {
      "Content-Type": "application/json",
    });

    // log(response.body.toString());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw ExistDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signIn(UserModel userModel1) async {
    final Map<String, dynamic> body = {
      "phone": userModel1.phone,
      "password": userModel1.password,
    };

    final reqBody = json.encode(body);

    final response = await client
        .post(Uri.parse("$baseUrlApi/test/log_in/"), body: reqBody, headers: {
      "Content-Type": "application/json",
    });

    final userJsonDecoded = json.decode(response.body);
    final UserDataModel userDataModel = UserDataModel.fromJson(userJsonDecoded);
    final UserModel userModel = userDataModel.dataModel.userModel;
    

    //log(userDataModel.dataModel.userModel.toJson().toString());
    //log(response.body.toString());
    sharedPreferences.setString("USERNAME", userModel.username!);


    if (response.statusCode == 200) {
      return (userModel);
    } else if (response.statusCode == 402) {
      throw CredentionalsException();
    } else {
      throw ServerException();
    }
  }
}
