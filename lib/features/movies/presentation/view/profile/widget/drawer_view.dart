import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/core/widgets/drop_down_button.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

List<String> Themeitems = ['Dark', 'Light'];
String currentthemeValue = 'Light';
List<String> languageitems = ['Arabic', 'English'];
String currentlanguageValue = 'English';

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: Color(0xff212121),
          width: double.infinity,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(Assets.avatar.avatar1.path),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Hello , \n John Safwat',
                  style: TextStyle(
                    color: AppColors.yellowColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 24),

              ListTile(
                leading: Icon(Icons.language, color: AppColors.yellowColor),
                title: Text(
                  'Language',
                  style: TextStyle(
                    color: AppColors.yellowColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              DropDownButton(
                items: languageitems,
                value: currentlanguageValue,
                onChanged: (value) {
                  setState(() {
                    currentlanguageValue = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}