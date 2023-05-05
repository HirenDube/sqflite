import 'package:flutter/material.dart';

class WaHeAe extends StatefulWidget {
  const WaHeAe({Key? key}) : super(key: key);

  @override
  State<WaHeAe> createState() => _WaHeAeState();
}

class _WaHeAeState extends State<WaHeAe> {

  Color scaffoldColor =Colors.black;
  String imageUrl =
      "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/dcc9fcba-b3a3-4b3a-a96f-c0c7cd0bcd6b/d5f425g-e4f464a3-13a2-413e-a391-bcdb66ecf94f.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2RjYzlmY2JhLWIzYTMtNGIzYS1hOTZmLWMwYzdjZDBiY2Q2YlwvZDVmNDI1Zy1lNGY0NjRhMy0xM2EyLTQxM2UtYTM5MS1iY2RiNjZlY2Y5NGYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.KQcTTgSfffy14Tn-gdpJ_ON98ZNokDOCes3qPS9WFVE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text("Whatsapp Hero Animation"),
      ),
      body: ListView(
        children: [
          ListTile(
            tileColor: Colors.grey,
            title: Text("User xyz"),
            leading: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => Hero(
                      tag: "ProfilePic",
                      child: Dialog(
                          child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Hero(
                                      tag: "ProfilePic",
                                      child: Scaffold(
                                        backgroundColor: scaffoldColor,
                                            appBar: AppBar(
                                              backgroundColor: scaffoldColor,
                                              title: Text(
                                                "User xyz",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            body: Center(
                                              child: Image.network(
                                                imageUrl,
                                              ),
                                            ),
                                          ),
                                    )));
                              },
                              child: Stack(children: [
                                Center(
                                  child: Image.network(
                                    imageUrl,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Opacity(
                                    opacity: 0.5,
                                    child: Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        color: Colors.black,
                                        height: 35,
                                        child: Text(
                                          "User xyz",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )),
                              ]),
                            ),
                            ButtonBar(
                              mainAxisSize: MainAxisSize.min,
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.chat, color: Colors.teal)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.call, color: Colors.teal)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.missed_video_call_sharp,
                                        color: Colors.teal)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.info_outline_rounded,
                                        color: Colors.teal)),
                              ],
                            )
                          ],
                        ),
                      )))),
              child: Hero(
                tag: "ProfilePic",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
