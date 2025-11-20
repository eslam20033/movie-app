part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserLoadingState extends ProfileState {}

final class GetUserSuccessState extends ProfileState {
  final ProfileModel profile;

  GetUserSuccessState(this.profile);
}

final class GetUserErrorState extends ProfileState {
  final String error;

  GetUserErrorState(this.error);
}
final class DeleteUserLoadingState extends ProfileState {}

final class DeleteUserSuccessState extends ProfileState {
}

final class DeleteUserErrorState extends ProfileState {
  final String error;

  DeleteUserErrorState(this.error);
}
final class UserUpdateLoadingState extends ProfileState {}

final class UserUpdateSuccessState extends ProfileState {
  final ProfileModel profile;

  UserUpdateSuccessState(this.profile);
}
final class UserUpdateErrorState extends ProfileState {
  final String error;

  UserUpdateErrorState(this.error);
}