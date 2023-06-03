import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SQLHelper.dart';

class SQFlite extends StatefulWidget {
  const SQFlite({Key? key}) : super(key: key);

  @override
  State<SQFlite> createState() => _SQFliteState();
}

class _SQFliteState extends State<SQFlite> {
  List<Map> ldata = <Map>[];
  bool update = false;

  GlobalKey<FormState> validatorKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController collegeC = TextEditingController();
  TextEditingController rollNoC = TextEditingController();

  late int pos;

  late List rolls;

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
                            if (rolls.contains(int.parse(valid))) {
                              return "Roll No. must be unique !!";
                            } else {
                              return null;
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
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
                        controller: nameC,
                        validator: (valid) {
                          if (valid!.isNotEmpty) {
                            return null;
                          } else {
                            return "Name can't be empty !!";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Name : ",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ), // Name
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: collegeC,
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
                style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.systemBlue),
                  onPressed: () {
                    if (validatorKey.currentState!.validate()) {
                      setState(() {
                        update
                            ? SQLHelper.update(
                                rollNo: int.parse(rollNoC.text),
                                oldroll: ldata[pos]["RollNo"],
                                name: nameC.text,
                                college: collegeC.text)
                            : SQLHelper.insertInto(
                                rollNo: int.parse(rollNoC.text),
                                name: nameC.text,
                                college: collegeC.text);
                        rollNoC.text = "";
                        nameC.text = "";
                        collegeC.text = "";
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
                height: MediaQuery.of(context).size.height - 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: ldata.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        isThreeLine: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: CupertinoColors.systemPurple,width: 2)),
                        title: Text("Roll No. : ${ldata[index]["RollNo"]}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : ${ldata[index]["Name"]}"),
                            Text("College : ${ldata[index]["College"]}"),
                          ],
                        ),
                        trailing:
                            ButtonBar(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  update = true;
                                  pos = index;
                                  collegeC.text = "${ldata[index]["College"]}";
                                  nameC.text = "${ldata[index]["Name"]}";
                                  rollNoC.text = "${ldata[index]["RollNo"]}";
                                  print("object");
                                });
                              },
                              icon: Icon(Icons.edit,color: CupertinoColors.systemGreen,)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(
                                              "Are you sure you want to delete this emtry ?"),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  SQLHelper.removeFrom(
                                                      ldata[index]["RollNo"]);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Entry Deleted Successfully",
                                                    ),
                                                    backgroundColor: Colors.red,
                                                    behavior:
                                                        SnackBarBehavior.floating,
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
                              icon: Icon(Icons.delete,color: CupertinoColors.systemRed,))
                        ]),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
