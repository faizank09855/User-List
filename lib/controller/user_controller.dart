import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/model/user_model.dart';
import '../model/image_model.dart';
import '../utils/database.dart';

class UserController extends GetxController {
  Rx<User> user = User(data: []).obs;
  RxList<UserImage> userImage = RxList([]);

  DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxString latitude = RxString("");
  RxString longitude = RxString("");
  RxString address = RxString('');

  getAllData() async {
    await getDataBase();
    user.value = await User().getUsers();
    Position position = await _determinePosition();
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.latitude);
    address.value = "${placemarks[0].name} ${placemarks[0].subLocality!}";
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  imagePick(index) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      File file = File(xFile.path);
      user.value.data![index].file = file;
      user.refresh();
      final list = await dbHelper.getUserImages(user.value.data![index].id);
      if (list.isEmpty) {
        insert(userId: user.value.data![index].id, file: file.path);
      } else {
        dbHelper.updateUserImage(UserImage(
            imagePath: file.path, userId: user.value.data![index].id!));
      }
      await getDataBase();
      user.refresh();
    }
  }

  getDataBase() async {
    List<UserImage> imageList = await dbHelper.getAllImages();
    userImage.value = imageList;
    imageList.forEach((e) {
      print(e.toMap());
    });
  }

  insert({userId, file}) async {
    dbHelper.insertUserImage(UserImage(imagePath: file, userId: userId));
  }
}
