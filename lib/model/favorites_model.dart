class FavoritesModel {
  FavoritesModel({
      this.message, 
      this.data,});

  FavoritesModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
FavoritesModel copyWith({  String? message,
  Data? data,
}) => FavoritesModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
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

  Data.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
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