class AuthModel {
  AuthModel({
      this.message, 
      this.data,});

  AuthModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
  }
  String? message;
  String? data;
AuthModel copyWith({  String? message,
  String? data,
}) => AuthModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}