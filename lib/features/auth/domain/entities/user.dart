import 'package:equatable/equatable.dart';

// class UserData extends Equatable {
//   final Data data;

//   const UserData({required this.data});

//   @override
//   List<Object?> get props => [data];
// }

// class Data extends Equatable {
//   final User user;

//   const Data({required this.user});

//   @override
//   List<Object?> get props => [user];
// }

class User extends Equatable {
  final int? id;
  final String? username;
  final String? fullname;
  final String? password;
  final String? phone;
  final String? timeStamp;

  const User({
    this.id,
    this.username,
    this.fullname,
    this.password,
    this.phone,
    this.timeStamp,
  });

  @override
  List<Object?> get props =>
      [id, username, phone, fullname, password, timeStamp];
}
