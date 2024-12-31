import 'dart:convert';
import 'dart:typed_data';

class UserImage {
  int? id;
  String imagePath;
  int userId;

  UserImage({
    this.id,
    required this.imagePath,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'userId': userId,
    };
  }

  factory UserImage.fromMap(Map<String, dynamic> map) {
    return UserImage(
      id: map['id'],
      imagePath: map['imagePath'],
      userId: map['userId'],
    );
  }
}
