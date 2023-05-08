import 'dart:convert';
import 'package:crud_pract_2nd_app/Set%20Wallpaper.dart';
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
  List imageData = [];
  int page = 1;

  String searchQuery = "nature";

  void initState() {
    fetchPixelsApiData();
    super.initState();
  }

  fetchPixelsApiData() async {
    await https.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=${searchQuery}&per_page=80&orientation=portrait",
        ),
        headers: {
          "Authorization":
              "cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w"
        }).then((value) {
      Map apiData = jsonDecode(value.body);
      setState(() {
        imageData = apiData["photos"];
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
          "https://api.pexels.com/v1/search?query=$searchQuery&per_page=80&orientation=portrait&page=$page",
        ),
        headers: {
          "Authorization":
              "cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w"
        }).then((value) {
      Map apiData = jsonDecode(value.body);
      setState(() {
        imageData.addAll(apiData["photos"]);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar:
          buildAppBar(title: "My Wallpaper App", bgColor: Colors.deepPurpleAccent),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value){
                setState(() {
                  searchQuery = value;
                  fetchPixelsApiData();
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: "Enter search Query : "
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: imageData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SetWallpaper(imageUrl: "${imageData[index]["src"]["large2x"]}",tag: "wallpaper[$index]")

                          ));
                        },
                        child: Container(
                          color: Colors.grey,
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: "wallpaper[$index]",
                            child: Image.network(
                              "${imageData[index]["src"]["tiny"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          GestureDetector(
            onTap: loadMoreData,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                height: 60,
                child: Text(
                  "Load More Wallapapers",
                  style: GoogleFonts.julee(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

// pixels api key cKLXs3wd22ttfeHO8Mc0nIflsOKaaA4lKGyMj8rw6Em2UtYZ6QZpaW1w
