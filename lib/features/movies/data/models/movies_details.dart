import 'package:flutter_application_1/features/movies/data/models/movie_model.dart';

class MoviesDetails {
  MoviesDetails({
      this.status, 
      this.statusMessage, 
      this.data,});

  MoviesDetails.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;
MoviesDetails copyWith({  String? status,
  String? statusMessage,
  Data? data,
}) => MoviesDetails(  status: status ?? this.status,
  statusMessage: statusMessage ?? this.statusMessage,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.movie,});

  Data.fromJson(dynamic json) {
    movie = json['movie'] != null ? Movies.fromJson(json['movie']) : null;
  }
  Movies? movie;
Data copyWith({  Movies? movie,
}) => Data(  movie: movie ?? this.movie,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }

}

