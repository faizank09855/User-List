import 'dart:io';

import 'package:flutter/material.dart';

import '../controller/user_controller.dart';
import '../model/user_model.dart';
import 'widgets.dart';

class CustomListTile extends StatefulWidget {
  final File? file;
  final Data? user;
  final bool? isShow;
  final int? index;

  final UserController? userController;

  const CustomListTile(
      {super.key,
      this.file,
      this.user,
      this.isShow,
      this.index,
      this.userController});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;

  AnimationController? animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    animation = Tween<double>(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.linear));
    animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation! , child: ListTile(
      title: title(widget.user),
      leading: leading(widget.isShow, widget.user, widget.file),
      subtitle: subtitle(widget.user),
      trailing: trailing(widget.index, widget.userController),
    ),);
  }
}
