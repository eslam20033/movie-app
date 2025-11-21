class GetAllFavoriteModel {
  GetAllFavoriteModel({
      this.message, 
      this.data,});

  GetAllFavoriteModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? message;
  List<Data>? data;
GetAllFavoriteModel copyWith({  String? message,
  List<Data>? data,
}) => GetAllFavoriteModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.movieId,
      this.name,
      this.rating,
      this.imageURL,
      this.year,});
  int get id => int.tryParse(movieId ?? '0') ?? 0;
  Data.fromJson(dynamic json) {
    movieId = json['movieId']?.toString();
    name = json['name'];
    rating = json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;
Data copyWith({  String? movieId,
  String? name,
  double? rating,
  String? imageURL,
  String? year,
}) => Data(  movieId: movieId ?? this.movieId,
  name: name ?? this.name,
  rating: rating ?? this.rating,
  imageURL: imageURL ?? this.imageURL,
  year: year ?? this.year,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }

}