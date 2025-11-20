import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/api/profile_service.dart';
import 'package:flutter_application_1/model/profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUser() async {
    emit(GetUserLoadingState());
    try {
      final response = await ProfileService.getUser();
      final profileData = ProfileModel.fromJson(response.data);
      emit(GetUserSuccessState(profileData));
    } catch (e) {
      emit(GetUserErrorState(e.toString()));
    }
  }

  Future<void> updateUser({String? name, int? avatarId, String? phone}) async {
    emit(UserUpdateLoadingState());
    try {
      final response = await ProfileService.updateUser(
        name: name,
        avatarId: avatarId,
        phone: phone,
      );
      final profileData = ProfileModel.fromJson(response.data);
      emit(UserUpdateSuccessState(profileData));
    } catch (e) {
      emit(UserUpdateErrorState(e.toString()));
    }
  }

  Future<void> deleteUser() async {
    emit(DeleteUserLoadingState());
    try {
      await ProfileService.deleteUser();
      emit(DeleteUserSuccessState());
    } catch (e) {
      emit(UserUpdateErrorState(e.toString()));
    }
  }
}
