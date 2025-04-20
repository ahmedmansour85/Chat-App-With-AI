import 'package:chat_app_with_ai/core/theming/color_managers.dart';
import 'package:flutter/material.dart';

class Constants {
  BoxDecoration decoritonBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
      stops: const [0.2, 0.5],
    ),
  );

  Widget tabBar(tabController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TabBar(
        controller: tabController,
        unselectedLabelColor: ColorManagers.secondaryColor.withOpacity(0.5),
        labelColor: ColorManagers.onErrorColor,
        tabs: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Sign In', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Sign Up', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
