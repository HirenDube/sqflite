import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'SQLHelper.dart';

class SQFlite extends StatefulWidget {
  const SQFlite({Key? key}) : super(key: key);

  @override
  State<SQFlite> createState() => _SQFliteState();
}

class _SQFliteState extends State<SQFlite> {
  List<Map> ldata = <Map>[];
  bool update = false, imgAvailbale = false;

  GlobalKey<FormState> validatorKey = GlobalKey<FormState>();

  TextEditingController fNameC = TextEditingController();
  TextEditingController lNameC = TextEditingController();
  TextEditingController collegeC = TextEditingController();
  TextEditingController rollNoC = TextEditingController();

  late int pos;

  late List rolls;

  XFile? photo;
  File? newPhoto;
  String photoString = "NoBytesAvailable";

  Uint8List pString = Uint8List(2);

  @override
  void initState() {
    // TODO: implement initState
    prevdata();
    super.initState();
  }

  void prevdata() async {
    ldata = await SQLHelper.getData();
    rolls = ldata.map((e) => e["RollNo"]).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                prevdata();
                print(Uint8List.fromList([0]));

                // print("${ldata}");
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text("SQFlite"),
        backgroundColor: CupertinoColors.systemPurple,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      photo = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(() {
                        imgAvailbale = true;
                      });
                    },
                    child: buildCircleAvatarPick(),
                  ),
                ),
              ),
              Form(
                key: validatorKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: rollNoC,
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return "Roll No. can't be empty !!";
                          } else {
                            if (int.tryParse(valid) != null) {
                              if (rolls.contains(int.parse(valid))) {
                                rolls.remove(int.parse(valid));
                                if (rolls.contains(int.parse(valid))) {
                                  return "Roll No. must be unique !!";
                                } else {
                                  return null;
                                }
                              } else {
                                return null;
                              }
                            } else {
                              return "Roll No. must be a number !!";
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "Roll No. : ",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ), // Roll No
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: fNameC,
                        validator: (valid) {
                          if (valid!.isNotEmpty) {
                            return null;
                          } else {
                            return "First Name can't be empty !!";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "First Name : ",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ), // First Name
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: lNameC,
                        textInputAction: TextInputAction.next,
                        validator: (valid) {
                          if (valid!.isNotEmpty) {
                            return null;
                          } else {
                            return "Last Name can't be empty !!";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Last Name : ",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ), // Last Name
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: collegeC,
                        textInputAction: TextInputAction.done,
                        validator: (valid) {
                          if (valid!.isNotEmpty) {
                            return null;
                          } else {
                            return "College name can't be empty !!";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "College : ",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ), // College
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CupertinoColors.systemBlue),
                  onPressed: () {
                    if (validatorKey.currentState!.validate()) {
                      // giveImage();
                      setState(() {
                        update
                            ? SQLHelper.update(
                                imgBytes: pString,
                                rollNo: int.parse(rollNoC.text),
                                oldroll: ldata[pos]["RollNo"],
                                fname: fNameC.text,
                                //imgBytes = "NoBytesAvailable"
                                college: collegeC.text,
                                lname: lNameC.text)
                            : SQLHelper.insertInto(
                                imgBytes: imgAvailbale ? pString : Uint8List.fromList([0]),
                                rollNo: int.parse(rollNoC.text),
                                fname: fNameC.text,
                                college: collegeC.text,
                                lname: lNameC.text);
                        rollNoC.text = "";
                        fNameC.text = "";
                        lNameC.text = "";
                        collegeC.text = "";
                        pString = Uint8List.fromList([0]);
                        imgAvailbale = false;

                        prevdata();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(update
                                ? "Entry Updated Successfully.."
                                : "Entry Added Successfully.."),
                            backgroundColor:
                                update ? Colors.green : Colors.blue,
                            dismissDirection: DismissDirection.horizontal,
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true));
                        update = false;
                      });
                    }
                  },
                  child: Text(update ? "UPDATE" : "ADD")),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height - 580,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: ldata.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: buildCircleAvatarView(index),
                        isThreeLine: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: CupertinoColors.systemPurple, width: 2)),
                        title: Text("Roll No. : ${ldata[index]["RollNo"]}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Name : ${ldata[index]["FName"]} ${ldata[index]["LName"]}"),
                            Text("College : ${ldata[index]["College"]}"),
                          ],
                        ),
                        trailing: ButtonBar(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      update = true;
                                      pos = index;
                                      collegeC.text =
                                          "${ldata[index]["College"]}";
                                      fNameC.text = "${ldata[index]["FName"]}";
                                      lNameC.text = "${ldata[index]["LName"]}";
                                      rollNoC.text =
                                          "${ldata[index]["RollNo"]}";
                                      // print("object");
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: CupertinoColors.systemGreen,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              title: Text(
                                                  "Are you sure you want to delete this emtry ?"),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      SQLHelper.removeFrom(
                                                          ldata[index]
                                                              ["RollNo"]);
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          "Entry Deleted Successfully",
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        dismissDirection:
                                                            DismissDirection
                                                                .horizontal,
                                                        showCloseIcon: true,
                                                      ));
                                                      prevdata();
                                                    },
                                                    child: Text(
                                                      "YES",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "NO",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 20),
                                                    ))
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: CupertinoColors.systemRed,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
              )
            ],
          ),
        ],
      ),
    );
  }

  // void giveImage() async {
  //   Uint8List? xyz = await File(photo!.path).readAsBytes();
  //   print(base64Encode(xyz));
  //   // if (imgAvailbale) {
  //     photoString = await base64Encode(xyz) == "" ?  base64Encode(xyz) : "NoBytesAvailable";
  //   // }
  // }

  CircleAvatar buildCircleAvatarPick() {
    if (imgAvailbale) {
      if (photo != null) {
        // setState(() {});
        name();
        return CircleAvatar(
          radius: 40,
          // backgroundImage: FileImage((File(photo!.path))),
          backgroundImage: MemoryImage(pString),
        );
      }
    }
    else if(update){
      List pic = jsonDecode(ldata[pos]["ImageBytes"]);
      List<int> pic1 = [];
      pic.forEach((e) => pic1.add(e));
      return CircleAvatar(
        radius: 40,
        // backgroundImage: FileImage((File(photo!.path))),
        backgroundImage: MemoryImage(Uint8List.fromList(pic1)),
      );
    }

    return CircleAvatar(
      radius: 40,
      child: Icon(
        Icons.account_circle,
        size: 80,
      ),
    );
  }

  CircleAvatar buildCircleAvatarView(int index) {
    if (ldata[index]["ImageBytes"] != "NoBytesAvailable") {
      // print("Uintfromdb=>\n");
      // print(ldata[index]["ImageBytes"]);
      List pic = jsonDecode(ldata[index]["ImageBytes"]);
      List<int> pic1 = [];
      pic.forEach((e) => pic1.add(e));
      // print(pic1.runtimeType);
      // print(pic1);
      // print(pic1.length);
      // return CircleAvatar(
      //   radius: 20,
      //   child: Icon(
      //     Icons.account_circle,
      //     size: 40,
      //   ),
      // );

      if(ldata[index]["ImageBytes"] == "[0]"){
        return CircleAvatar(
          radius: 20,
          child: Icon(
            Icons.account_circle,
            size: 40,
          ),
        );
      }

      return CircleAvatar(
        radius: 20,
        // backgroundImage: FileImage((File(photo!.path))),
        backgroundImage: MemoryImage(Uint8List.fromList(pic1)),
      );
    }

    return CircleAvatar(
      radius: 20,
      child: Icon(
        Icons.account_circle,
        size: 40,
      ),
    );
  }

  void name() async {

      pString = await File(photo!.path).readAsBytes();


    // setState(() {});
  }
}
