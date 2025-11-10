import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int selectedIndex = -1;

  List<String> avatars = [
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

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: Text('Pick Avatar')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff282A28),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(19),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 1,
                                  ),
                              itemCount: avatars.length,
                              itemBuilder: (context, index) {
                                bool isSelected = selectedIndex == index;

                                return InkWell(
                                  onTap: () {
                                    setState(() => selectedIndex = index);
                                    Navigator.pop(context);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: AppColors.yellowColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: 0.22*w,
                                            height: 0.1*h,
                                            child: Image.asset(
                                              avatars[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),

                                      if (isSelected)
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.yellowColor
                                                    .withValues(alpha: 0.56),
                                                border: Border.all(
                                                  color: AppColors.yellowColor,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                height: 0.1*h,
                                                width: 0.22*w,
                                                child: Image.asset(
                                                  avatars[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: 0.41*w,
                  height: 0.19*h,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      selectedIndex == -1
                          ? Assets.avatar.avatar1.path
                          : avatars[selectedIndex],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0.03*h),

              CustomTextFormField(
                hintText: 'John Safwat',
                prefixIcon: Icons.person,
              ),

              SizedBox(height: 0.025*h),
              CustomTextFormField(
                hintText: '01200000000',
                prefixIcon: Icons.phone,
              ),

              SizedBox(height: 0.03*h),

              Row(
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 0.25*h),
              SizedBox(
                width: double.infinity,
                height: 0.07*h,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 0.02*h),
              SizedBox(
                height: 0.07*h,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Update Data',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 0.03*h,),
            ],
          ),
        ),
      ),
    );
  }
}
