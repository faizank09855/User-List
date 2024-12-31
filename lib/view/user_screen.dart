import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/controller/user_controller.dart';
import 'package:practice_project/view/custom_list_tile.dart';
import 'widgets.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController();
  Animation<Offset>? animation;

  AnimationController? animationController;

  @override
  void initState() {
    userController.getAllData();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400),
    );
    animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut, // Animation curve
    ));
    animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          SlideTransition(
            position: animation!,
            child: locationCard(userController),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            child: Obx(() {
              return ListView.builder(
                itemCount: userController.user.value.data!.length,
                itemBuilder: (context, index) {
                  final user = userController.user.value.data![index];
                  File? file;
                  bool isShow = false;
                  for (var item in userController.userImage.value) {
                    if (item.userId == user.id) {
                      file = File(item.imagePath);
                      isShow = true;
                    }
                  }
                  return CustomListTile(file: file,user: user, isShow: isShow,index: index, userController: userController,);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
