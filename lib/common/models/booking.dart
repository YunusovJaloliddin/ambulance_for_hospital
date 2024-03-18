import 'package:json_annotation/json_annotation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'user_model.dart';

class Booking {
  UserModel userModel;
  DateTime dateTime;
  Point point;
  int answerTime;
  double stars;
  String reason;
  String address;
  Status status;

  Booking({
    required this.userModel,
    required this.reason,
    required this.address,
    required this.point,
    DateTime? dateTime,
    int? answerTime,
    double? stars,
    Status? status,
  })  : dateTime = dateTime ?? DateTime.now(),
        answerTime = answerTime ?? 0,
        stars = stars ?? 0,
        status = status ?? Status.request;

  Booking copyWith({
    UserModel? userModel,
    DateTime? dateTime,
    int? answerTime,
    Point? point,
    double? stars,
    String? reason,
    String? address,
    Status? status,
  }) {
    return Booking(
      userModel: userModel ?? this.userModel,
      reason: reason ?? this.reason,
      point: point ?? this.point,
      answerTime: answerTime ?? this.answerTime,
      dateTime: dateTime ?? this.dateTime,
      stars: stars ?? this.stars,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }

  factory Booking.fromJson(Map<Object?, Object?> json) {
    Booking booking= Booking(
        userModel:
            UserModel.fromJson(json['userModel'] as Map<Object?, Object?>),
        reason: json['reason'] as String,
        point: json['point'] != null
            ? Point(
                latitude: (json['point'] as Map<Object?, Object?>)['latitude'] as double,
                longitude: (json['point'] as Map<Object?, Object?>)['longitude'] as double,
              )
            : const Point(latitude: 41.3265931, longitude: 69.3265931),
        address: json['address'] as String,
        dateTime: json['dateTime'] == null
            ? null
            : DateTime.parse(json['dateTime'] as String),
        answerTime: json['answerTime'] as int?,
        stars: (json['stars'] as num?)?.toDouble(),
        status: $enumDecode(_$StatusEnumMap, json['status']));
    return booking;
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'userModel': userModel.toJson(),
        'dateTime': dateTime.toIso8601String(),
        'answerTime': answerTime,
        'point': point.toJson(),
        'stars': stars,
        'reason': reason,
        'address': address,
        'status': _$StatusEnumMap[status]!,
      };

  @override
  String toString() {
    return 'Booking{userModel: $userModel, dateTime: $dateTime, answerTime: $answerTime, stars: $stars, reason: $reason}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking &&
          runtimeType == other.runtimeType &&
          userModel == other.userModel &&
          dateTime == other.dateTime &&
          answerTime == other.answerTime &&
          stars == other.stars &&
          reason == other.reason;

  @override
  int get hashCode =>
      userModel.hashCode ^
      dateTime.hashCode ^
      answerTime.hashCode ^
      stars.hashCode ^
      reason.hashCode;
}

enum Status {
  request,
  accept,
  complete,
}

const _$StatusEnumMap = {
  Status.request: 'request',
  Status.accept: 'accept',
  Status.complete: 'complete',
};
