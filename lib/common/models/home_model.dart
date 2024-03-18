import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'booking.dart';
import 'user_model.dart';

class HomeModel {
  String name;
  String address;
  Point point;
  List<UserModel> users;
  List<Booking> bookingHistory;

  HomeModel({
    required this.name,
    required this.address,
    required this.point,
    List<UserModel>? users,
    List<Booking>? bookingHistory,
  })  : users = users ?? [],
        bookingHistory = bookingHistory ?? [];

  HomeModel copyWith({
    String? name,
    String? address,
    Point? point,
    List<UserModel>? users,
    List<Booking>? bookingHistory,
  }) =>
      HomeModel(
        name: name ?? this.name,
        address: address ?? this.address,
        point: point ?? this.point,
        users: users ?? this.users,
        bookingHistory: bookingHistory ?? this.bookingHistory,
      );

  factory HomeModel.fromJson(Map<String, Object?> json) => HomeModel(
        name: json['name'] as String,
        address: json['address'] as String,
        point: json['point'] != null
            ? Point(
                latitude: (json['point'] as Map<String, dynamic>)['latitude'],
                longitude: (json['point'] as Map<String, dynamic>)['longitude'],
              )
            : const Point(latitude: 42, longitude: 42),
        users: json['users'] != null
            ? (json['users'] as List<Object?>?)
                ?.map((e) => UserModel.fromJson(e as Map<String, Object?>))
                .toList()
            : [],
        bookingHistory: json['bookingHistory'] != null
            ? (json['bookingHistory'] as List<Object?>?)
                ?.map((e) => Booking.fromJson(e as Map<String, Object?>))
                .toList()
            : [],
      );

  Map<String, Object?> toJson() => <String, Object?>{
        'name': name,
        'address': address,
        'point': point.toJson(),
        'users': users.map((e) => e.toJson()).toList(),
        'bookingHistory': bookingHistory.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'HomeModel{name: $name, address: $address, users: $users, bookingHistory: $bookingHistory}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          users == other.users &&
          bookingHistory == other.bookingHistory;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      users.hashCode ^
      bookingHistory.hashCode;
}
