import 'dart:io';

import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PickTheImage extends StatefulWidget {
  const PickTheImage({Key? key}) : super(key: key);

  @override
  State<PickTheImage> createState() => _PickTheImageState();
}

class _PickTheImageState extends State<PickTheImage> {
  File? imageFile;
  ImagePicker imgPic = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Image Picker Practice", bgColor: Colors.pinkAccent),
      body: ListView(
        children: [
          RichText(
            text: TextSpan(
                text: "Welcome to the",
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.blue),
                children: [
                  TextSpan(
                      text: " Image Picker Tool",
                      style:
                          GoogleFonts.cabin(fontSize: 30, color: Colors.green)),
                  TextSpan(
                    text: " made in flutter",
                    style: GoogleFonts.cabin(fontSize: 20, color: Colors.blue),
                  )
                ]),
          ),
          Text(
            "Choose Profile picture from any of this option.",
            style: GoogleFonts.cabin(fontSize: 15, color: Colors.red),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    _imagePicker(imgSrc: ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt)),
              IconButton(
                  onPressed:() {
                    _imagePicker(imgSrc: ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo_library))
            ],
          ),
          imageFile == null
              ? Placeholder(fallbackHeight: 200,
                  fallbackWidth: 200,
                  strokeWidth: 2,
                  child: Text("Please Choose Image First"),
                )
              : Image.file(imageFile!)
        ],
      ),
    );
  }

  _imagePicker({required ImageSource imgSrc}) async {
    XFile? file = await imgPic.pickImage(source: imgSrc);
    setState(() {
      imageFile = File(file!.path);
    });
  }
}
