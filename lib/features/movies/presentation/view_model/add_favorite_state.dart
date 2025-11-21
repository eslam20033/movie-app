part of 'add_favorite_cubit.dart';

@immutable
sealed class AddFavoriteState {}

final class AddFavoriteInitial extends AddFavoriteState {}

final class AddFavoriteLoading extends AddFavoriteState {}

final class AddFavoriteSuccess extends AddFavoriteState {
  late final bool isFavorite;

  AddFavoriteSuccess({required this.isFavorite});
}

final class AddFavoriteRemoved extends AddFavoriteState {}

final class AddFavoriteChecked extends AddFavoriteState {
  final bool isFavorite;

  AddFavoriteChecked({required this.isFavorite});
}

final class AddFavoriteError extends AddFavoriteState {
  final String errorMessage;

  AddFavoriteError({required this.errorMessage});
}

final class GetFavoriteLoading extends AddFavoriteState {}

final class GetFavoriteSuccess extends AddFavoriteState {
  final bool isFavorite;

  GetFavoriteSuccess({required this.isFavorite});
}

final class GetFavoriteError extends AddFavoriteState {
  final String errorMessage;

  GetFavoriteError({required this.errorMessage});
}

final class GetAllFavoriteLoading extends AddFavoriteState {}

final class GetAllFavoriteSuccess extends AddFavoriteState {
  final List<Data> favoriteList;

  GetAllFavoriteSuccess({required this.favoriteList});
}

final class GetAllFavoriteError extends AddFavoriteState {
  final String errorMessage;

  GetAllFavoriteError({required this.errorMessage});
}
