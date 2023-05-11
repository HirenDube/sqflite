import 'dart:io';
import 'dart:typed_data';

import 'package:crud_pract_2nd_app/main.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BasicImageEditor extends StatefulWidget {
  const BasicImageEditor({Key? key}) : super(key: key);

  @override
  State<BasicImageEditor> createState() => _BasicImageEditorState();
}

class _BasicImageEditorState extends State<BasicImageEditor> {
  var _editorKey = GlobalKey<ExtendedImageEditorState>();

  // String url =
  //     "https://m.media-amazon.com/images/M/MV5BM2JjYmUyN2MtODIyOC00ZmNiLWI5YTUtN2NiMWQzNmM3OGU1XkEyXkFqcGdeQXVyNDk3NDEzMzk@._V1_FMjpg_UX1000_.jpg";

  String url =
      "https://static1.srcdn.com/wordpress/wp-content/uploads/2022/01/Boruto-Orochimaru.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Basic Image Editor App",
          bgColor: Colors.amber,
          actions: [
            IconButton(
                onPressed: () async {
                  if (_editorKey.currentState!.rawImageData != null) {
                    var iamge = _editorKey.currentState!.rawImageData;
                    saveImage(iamge);
                  }
                },
                icon: Icon(Icons.save_alt))
          ]),
      body: ExtendedImage.network(
        url,
        mode: ExtendedImageMode.editor,
        cacheRawData: true,
        extendedImageEditorKey: _editorKey,
        fit: BoxFit.contain,
        initEditorConfigHandler: (state) => EditorConfig(
            maxScale: 10.0,
            hitTestSize: 30.0,
            cropRectPadding: EdgeInsets.all(10.0),
            lineColor: Colors.red,
            cornerColor: Colors.amber),
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

  // Future<String> saveImage(Uint8List bytes) async {
  //   await [Permission.storage].request();
  //   final time = DateTime.now()
  //       .toIso8601String()
  //       .replaceAll('.', '_')
  //       .replaceAll(':', '_');
  //   final name = 'Screenshot_$time';
  //   final result = await ImageGallerySaver.saveImage(bytes, name: name);
  //   return result['filePath'];
  // }

  void saveImage(Uint8List imageData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = await File("${directory.path}/" +
            DateTime.now().toString().replaceAll(' ', '_') +
            ".jpg")
        .create();
    file.writeAsBytesSync(imageData);

    // final path = directory.path + '/image.png';
    //
    // await File(path).writeAsBytes(imageData);
    //
    print(
        'Image saved : ${"${directory.path}/${DateTime.now().toString().replaceAll(' ', '_').replaceAll('.', '_').replaceAll(':', '_')}.jpg"}');
  }
}
