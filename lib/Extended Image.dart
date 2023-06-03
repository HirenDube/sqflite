import 'dart:io';
import 'dart:typed_data';
import 'package:crud_pract_2nd_app/main.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class BasicImageEditor extends StatefulWidget {
  const BasicImageEditor({Key? key}) : super(key: key);

  @override
  State<BasicImageEditor> createState() => _BasicImageEditorState();
}

class _BasicImageEditorState extends State<BasicImageEditor> {
  var _editorKey = GlobalKey<ExtendedImageEditorState>();

  String url =
      "https://m.media-amazon.com/images/M/MV5BM2JjYmUyN2MtODIyOC00ZmNiLWI5YTUtN2NiMWQzNmM3OGU1XkEyXkFqcGdeQXVyNDk3NDEzMzk@._V1_FMjpg_UX1000_.jpg";

  // String url =
  //     "https://bleedingcool.com/wp-content/uploads/2021/04/45700086afb36912d1de9db2aaf61108-1200x900.jpg";

  ScreenshotController ssController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Basic Image Editor App",
          bgColor: Colors.teal,
          actions: [
            IconButton(
                onPressed: () async {
                  // screenshot of the widget
                  ssController
                    ..captureAsUiImage(pixelRatio: 5)
                    ..capture().then((imageBytes) {
                      if (imageBytes != null) {
                        saveImage12(imageBytes);
                      }
                    });

                  // original Image
                  // if (_editorKey.currentState!.rawImageData != null) {
                  //   saveImage12(_editorKey.currentState!.rawImageData);
                  // }

                },
                icon: Icon(Icons.save_alt))
          ]),
      body: Screenshot(
        controller: ssController,
        child: ExtendedImage.network(
          url,
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          colorBlendMode: BlendMode.saturation,
          gaplessPlayback: true,
          enableLoadState: true,
          scale: double.maxFinite,
          mode: ExtendedImageMode.editor,
          cacheRawData: true,
          extendedImageEditorKey: _editorKey,
          fit: BoxFit.contain,
          initEditorConfigHandler: (state) => EditorConfig(
              hitTestBehavior: HitTestBehavior.deferToChild,
              maxScale: 10.0,
              hitTestSize: 30.0,
              cropRectPadding: EdgeInsets.all(10.0),
              lineColor: Colors.red,
              cornerColor: Colors.amber),
        ),
      ),
      bottomNavigationBar: Material(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
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
                onPressed: () => _editorKey.currentState?.flip(),
                icon: Icon(Icons.flip)),
          ],
        ),
      ),
    );
  }

  String andMenifPermi = 'android:requestLegacyExternalStorage="true"';

  Future saveImage12(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'Screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    // return result['filePath'];
  }

// void saveImage(Uint8List imageData) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = await File("${directory.path}/" +
//           DateTime.now().toString().replaceAll(' ', '_') +
//           ".jpg")
//       .create();
//   file.writeAsBytesSync(imageData);
//
//   // final path = directory.path + '/image.png';
//   //
//   // await File(path).writeAsBytes(imageData);
//   //
//   print(
//       'Image saved : ${"${directory.path}/${DateTime.now().toString().replaceAll(' ', '_').replaceAll('.', '_').replaceAll(':', '_')}.jpg"}');
// }
}
