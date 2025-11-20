import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/features/movies/presentation/view/profile/cubit/profile_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/storage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<String> avatars = [
    Assets.avatar.avatar1.path,
    Assets.avatar.avatar2.path,
    Assets.avatar.avatar3.path,
    Assets.avatar.avatar4.path,
    Assets.avatar.avatar5.path,
    Assets.avatar.avatar6.path,
    Assets.avatar.avatar7.path,
    Assets.avatar.avatar8.path,
    Assets.avatar.avatar9.path,
  ];

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  int selectedAvatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: avatars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final bool isSelected = selectedAvatarIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = index;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.yellowColor
                              : Colors.transparent,
                          width: isSelected ? 4 : 0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(avatars[index]),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackgroundColor,
        foregroundColor: AppColors.yellowColor,
        title: const Text(
          "Update Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()..getUser(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetUserSuccessState) {
              _nameController.text = state.profile.data?.name ?? '';
              _phoneController.text = state.profile.data?.phone ?? '';
              selectedAvatarIndex = (state.profile.data?.avaterId ?? 1) - 1;
            }
            if (state is UserUpdateSuccessState) {
              context.read<ProfileCubit>().getUser();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("User Update Successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            }
            if (state is UserUpdateErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is DeleteUserSuccessState) {
              TokenManager.delete();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.loginRoute,
                (r) => false,
              );
            }
            if (state is DeleteUserErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading =
                state is GetUserLoadingState ||
                state is UserUpdateLoadingState ||
                state is DeleteUserLoadingState;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(
                            avatars[selectedAvatarIndex],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: _nameController.text,
                    prefixIconWidget: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    filledColor: AppColors.greyColor,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _phoneController,
                    hintText: _phoneController.text,
                    prefixIconWidget: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    filledColor: AppColors.greyColor,
                  ),
                  SizedBox(height: h * 0.24),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red[700],
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.yellowColor,
                                    scrollable: true,
                                    title: Text(
                                      'Do you want to delete this Account?',
                                    ),
                                    content: Text(
                                      'You cannot undo this action',
                                    ),
                                    actions: [
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(dialogContext);
                                              context
                                                  .read<ProfileCubit>()
                                                  .deleteUser();
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.yellowColor,
                            )
                          : const Text(
                              "Delete Account",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                      ),
                      onPressed: () {
                        context.read<ProfileCubit>().updateUser(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          avatarId: selectedAvatarIndex + 1,
                        );
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.yellowColor,
                            )
                          : Text(
                              "Update Account",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
