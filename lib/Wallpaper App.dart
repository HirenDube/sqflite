import 'dart:convert';
import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as https;

class MyWallpaperApp extends StatefulWidget {
  const MyWallpaperApp({Key? key}) : super(key: key);

  @override
  State<MyWallpaperApp> createState() => _MyWallpaperAppState();
}

class _MyWallpaperAppState extends State<MyWallpaperApp> {
  List imagData = [];

  int page = 1;

  void initState() {
    fetchPixelsApiData();
    super.initState();
  }

  fetchPixelsApiData() async {
    await https.get(
        Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=40",
        ),
        headers: {
          "Authorization":
              "cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w"
        }).then((value) {
      Map apiData = jsonDecode(value.body);
      setState(() {
        imagData = apiData["photos"];
      });
    });
  }

  loadMoreData() async {
    print("Hello world");
    setState(() {
      page++;
    });
    await https.get(
        Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=80&page=$page",
        ),
        headers: {
          "Authorization":
              "cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w"
        }).then((value) {
      Map apiData = jsonDecode(value.body);
      setState(() {
        imagData.addAll(apiData["photos"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(title: "My Wallpaper App", bgColor: Colors.deepPurple),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: GridView.builder(
                  itemCount: imagData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: buildAppBar(
                                    title: "${imagData[index]["url"]}",
                                    bgColor: Colors.deepPurple),
                                body: Center(
                                  child: Hero(
                                    tag: "wallpaper[$index]",
                                    child: Expanded(
                                      child: Image.network(imagData[index]
                                          ["src"]["large2x"]),
                                    ),
                                  ),
                                ),
                              )));
                        },
                        child: Container(
                          color: Colors.amber,
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: "wallpaper[$index]",
                            child: Image.network(
                              "${imagData[index]["src"]["tiny"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          ListTile(
            tileColor: Colors.grey,
            title: TextButton(
              onPressed: loadMoreData,
              child: Text(
                "Load More Wallapapers",
                style: GoogleFonts.julee(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// pixels api key cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w
