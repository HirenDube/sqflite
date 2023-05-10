import 'dart:io';
import 'dart:typed_data';

import 'package:crud_pract_2nd_app/main.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';


class BasicImageEditor extends StatefulWidget {
  const BasicImageEditor({Key? key}) : super(key: key);

  @override
  State<BasicImageEditor> createState() => _BasicImageEditorState();
}

class _BasicImageEditorState extends State<BasicImageEditor>
    with SingleTickerProviderStateMixin {
  var controller = ScreenshotController();
  Uint8List? imageBytes;

  var _editorKey = GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(title: "Basic Image Editor App", bgColor: Colors.amber),
      body: ExtendedImage.network(
        "https://static1.srcdn.com/wordpress/wp-content/uploads/2022/01/Boruto-Orochimaru.jpg",
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: _editorKey,
        fit: BoxFit.contain,
        initEditorConfigHandler: (state) => EditorConfig(
            maxScale: 10.0,
            hitTestSize: 30.0,
            cropRectPadding: EdgeInsets.all(10.0),
            lineColor: Colors.red,
            cornerColor: Colors.amber),
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ButtonBar(
          // alignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  if (_editorKey.currentState != null) {
                    _editorKey.currentState?.rotate(right: false);
                  }
                },
                icon: Icon(Icons.rotate_left)),
            IconButton(
                onPressed: () => _editorKey.currentState?.reset(),
                icon: Icon(Icons.restore)),
            IconButton(
                onPressed: () => _editorKey.currentState?.rotate(right: true),
                icon: Icon(Icons.rotate_right)),
            IconButton(
                onPressed: () {
                  final bytes = controller.captureFromWidget(Material(
                      child: ExtendedImage.network(
                    "https://static1.srcdn.com/wordpress/wp-content/uploads/2022/01/Boruto-Orochimaru.jpg",
                    mode: ExtendedImageMode.editor,
                    extendedImageEditorKey: _editorKey,
                    fit: BoxFit.contain,
                    initEditorConfigHandler: (state) => EditorConfig(
                        maxScale: 10.0,
                        hitTestSize: 30.0,
                        cropRectPadding: EdgeInsets.all(10.0),
                        lineColor: Colors.red,
                        cornerColor: Colors.amber),
                  )));
                  setState(() {
                    this.imageBytes = bytes as Uint8List?;
                  });

                  final location = getApplicationDocumentsDirectory();
                  final file = File("${location}/image.png");
                  file.writeAsBytes(imageBytes!);
                },
                icon: Icon(Icons.save_alt))
          ],
        ),
      ),
    );
  }
}
