// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entities/user.dart';

class UserDataModel {
  final DataModel dataModel;
  UserDataModel({
    required this.dataModel,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(dataModel: DataModel.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['data'] = dataModel.toJson();

    return data;
  }
}

class DataModel {
  final UserModel userModel;
  DataModel({
    required this.userModel,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      userModel: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['user'] = userModel.toJson();

    return data;
  }
}

class UserModel extends User {
  const UserModel({
    int? id,
    String? username,
    String? phone,
    String? fullname,
    String? password,
    String? timestamp,
  }) : super(
            id: id,
            username: username,
            phone: phone,
            fullname: fullname,
            password: password,
            timeStamp: timestamp);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['phone'] = phone;
    data['timestamp'] = timeStamp;
    return data;
  }
}
