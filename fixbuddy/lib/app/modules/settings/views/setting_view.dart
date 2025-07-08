import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'Setting'),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.25,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryColor,
                  AppColors.tritoryColor,
                  AppColors.whiteColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Custom List Tiles
                  CustomListTile(
                    leading: Icons.language,
                    title: Text('Languages'),
                    onTap: () {
                      print('Languages tapped');
                    },
                  ),

                  CustomListTile(
                    leading: Icons.location_on_outlined,
                    title: Text('Location'),
                    onTap: () {
                      // open location screen
                      print('Location tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
