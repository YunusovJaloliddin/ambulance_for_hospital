class UserModel {
  String name;
  String fulName;
  int age;
  String disease;
  double height;
  double wight;

  UserModel({
    required this.name,
    required this.fulName,
    required this.age,
    String? disease,
    double? height,
    double? wight,
  })  : disease = disease ?? "",
        height = height ?? 0,
        wight = wight ?? 0;

  UserModel copyWith({
    String? name,
    String? fulName,
    int? age,
    String? disease,
    double? height,
    double? wight,
  }) {
    return UserModel(
      name: name ?? this.name,
      fulName: fulName ?? this.fulName,
      age: age ?? this.age,
      disease: disease ?? this.disease,
      height: height ?? this.height,
      wight: wight ?? this.wight,
    );
  }


  factory UserModel.fromJson(Map<Object?, Object?> json) => UserModel(
    name: json['name'] as String,
    fulName: json['fulName'] as String,
    age: json['age'] as int,
    disease: json['disease'] as String?,
    height: (json['height'] as num?)?.toDouble(),
    wight: (json['wight'] as num?)?.toDouble(),
  );

  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'fulName': fulName,
    'age': age,
    'disease': disease,
    'height': height,
    'wight': wight,
  };


  @override
  String toString() {
    return 'UserModel{name: $name, fulName: $fulName, age: $age, disease: $disease, height: $height, wight: $wight}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          fulName == other.fulName &&
          age == other.age &&
          disease == other.disease &&
          height == other.height &&
          wight == other.wight;

  @override
  int get hashCode =>
      name.hashCode ^
      fulName.hashCode ^
      age.hashCode ^
      disease.hashCode ^
      height.hashCode ^
      wight.hashCode;
}
