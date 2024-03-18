import 'booking.dart';
class ClinicModel {
  String name;
  String token;
  String address;
  int answerTime;
  double stars;
  List<Booking> bookingHistory;


  ClinicModel({
    required this.name,
    required this.address,
    required this.token,
    int? answerTime,
    double? stars,
    List<Booking>? bookingHistory,
  })  : answerTime = answerTime ?? 0,
        stars = stars ?? 0,
        bookingHistory = bookingHistory ?? [];

  ClinicModel copyWith({
    String? name,
    String? token,
    String? address,
    int? answerTime,
    double? stars,
    List<Booking>? bookingHistory,
  }) =>
      ClinicModel(
        name: name ?? this.name,
        address: address ?? this.address,
        token: token ?? this.token,
        answerTime: answerTime ?? this.answerTime,
        stars: stars ?? this.stars,
        bookingHistory: bookingHistory ?? this.bookingHistory,
      );


  factory ClinicModel.fromJson(Map<Object?, Object?> json) => ClinicModel(
    name: json['name'] as String,
    address: json['address'] as String,
    token: json['token'] as String,
    answerTime: json['answerTime'] as int?,
    stars: (json['stars'] as num?)?.toDouble(),
    bookingHistory: json['bookingHistory'] != null?(json['bookingHistory'] as List<Object?>?)
        ?.map((e) => Booking.fromJson(e as Map<Object?, Object?>))
        .toList():[],
  );

  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'token': token,
    'address': address,
    'answerTime': answerTime,
    'stars': stars,
    'bookingHistory': bookingHistory.map((e) => e.toJson()).toList(),
  };


  @override
  String toString() {
    return 'ClinicModel{name: $name, token: $token, address: $address, answerTime: $answerTime, stars: $stars, bookingHistory: $bookingHistory}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClinicModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          token == other.token &&
          address == other.address &&
          answerTime == other.answerTime &&
          stars == other.stars &&
          bookingHistory == other.bookingHistory;

  @override
  int get hashCode =>
      name.hashCode ^
      token.hashCode ^
      address.hashCode ^
      answerTime.hashCode ^
      stars.hashCode ^
      bookingHistory.hashCode;
}
