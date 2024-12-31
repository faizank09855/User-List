import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

final appbar = AppBar(
  backgroundColor: Colors.amberAccent,
  leading: Icon(CupertinoIcons.profile_circled),
  title: Text(
    "User List",
    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
  ),
);

title(user) {
  return Text(
    "${user.firstName!} ${user.lastName}",
    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
  );
}

leading(isShow ,user , file ){
  return CircleAvatar(
    backgroundImage:
    !isShow ? NetworkImage(user.avatar!) : FileImage(file!),
  );
}

subtitle(user){
  return Text(
    user.email!,
    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
  );
}

trailing(index , userController){
  return TouchableOpacity(
      onTap: () {
        userController.imagePick(index);
      },
      child: Icon(CupertinoIcons.arrow_up_circle)) ;
}

locationCard(userController){
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.amberAccent),
    child: Obx(() {
      return Row(
        spacing: 16,
        children: [
          Icon(CupertinoIcons.location),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "lat: ${userController.latitude} long: ${userController.longitude}",
                  style: GoogleFonts.poppins()),
              Text(
                "address : ${userController.address}",
                style: GoogleFonts.poppins(),
              )
            ],
          )
        ],
      );
    }),
  ) ;
}