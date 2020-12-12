import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StylistService {
  int _maxNumFilesAllowed = 5;

  static final FilePicker _picker = FilePicker.platform;

  Future<List<File>> getImage() async {
    List<File> _images = List();
    return await _picker
        .pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,
    )
        .then((pickerResult) {
      if (pickerResult != null) {
        _images.addAll(pickerResult.paths.map((path) => File(path)).toList());
        if (_images.length > _maxNumFilesAllowed) {
          Fluttertoast.showToast(msg: "You can select a maximum of 5 images");
          return _images.sublist(0, 5);
        }
        return _images;
      } else {
        Fluttertoast.showToast(msg: "No image selected");
      }
    }).catchError((error) {
      print(error.toString());
      if (error.runtimeType == PlatformException) {
        switch (error.code) {
          case "read_external_storage_denied":
            Fluttertoast.showToast(msg: "Storage permission denied");
            break;
          default:
            Fluttertoast.showToast(msg: "Something went wrong");
        }
      } else {
        print(
            "********************************** ${error.toString()} *************************************");
        Fluttertoast.showToast(msg: "No file selected");
      }
      return null;
    });
  }
}
