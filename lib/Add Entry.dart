 import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  Map data = {};

  AddEntry({required this.data}) {
    data = {
      "productId": <String>["34"],
      "productName": <String>[],
      "productStock": <int>[],
      "price": <int>[],
    };
  }

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  bool appModeDark = false;

  String welcomeMessage = "Welcome to My DataBase";

  GlobalKey<FormState> dataEntryConstraints = GlobalKey();

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productIdController = TextEditingController();
  TextEditingController productStockController = TextEditingController();

  int mesej = 0;

  @override
  void initState()  {
    // TODO: implement initState
    getBoolValue();
    super.initState();
  }

getBoolValue()async{
  SharedPreferences pref1 = await SharedPreferences.getInstance();
  appModeDark = pref1.getBool("appModeDark")!;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appModeDark ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            "Create DataBase",
            style: TextStyle(
              color: appModeDark ? Colors.black : Colors.white,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          actions: [
            Switch(
                inactiveThumbColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                thumbColor:
                MaterialStateColor.resolveWith((states) {
                  return appModeDark ? Colors.black : Colors.white;
                }),
                thumbIcon: MaterialStateProperty.resolveWith((states) {
                  return  Icon(appModeDark ? Icons.dark_mode : Icons.dark_mode_outlined,color: Colors.deepPurpleAccent);
                }),
                value: appModeDark,
                onChanged: (change) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    appModeDark = change;
                    prefs.setBool("appModeDark", change);
                  });
                })
          ],
        ),
        body: Center(
            child: Form(
              key: dataEntryConstraints,
              child: ListView(padding: EdgeInsets.all(20), children: [
                textFormField(
                    controller: productIdController,
                    label: 'Product ID : ',
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (value.contains(RegExp(r'^[0-9]'))) {
                          if (!(widget.data["productId"].contains(value))) {
                            return null;
                          } else {
                            return "Product Id should be unique only";
                          }
                        } else {
                          return "Product Id should be a number only";
                        }
                      } else {
                        return "Product Id can't be empty";
                      }
                    },
                    hint: 'Enter product id here..',
                    filledColor: Colors.grey),
                Divider(
                  color: Colors.transparent,
                ),
                textFormField(
                    controller: productNameController,
                    label: 'Product Name : ',
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (!(widget.data["productName"].contains(value))) {
                          return null;
                        } else {
                          return "Product Name should be unique only";
                        }
                      } else {
                        return "Product Name can't be empty";
                      }
                    },
                    hint: 'Enter product name here..',
                    filledColor: Colors.grey),
                Divider(
                  color: Colors.transparent,
                ),
                textFormField(
                    controller: priceController,
                    label: 'Product Price : ',
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (value.contains(RegExp(r'^[0-9]'))) {
                          return null;
                        } else {
                          return "Product price should be a number only";
                        }
                      } else {
                        return "Product price can't be empty";
                      }
                    },
                    hint: 'Enter product price here..',
                    filledColor: Colors.grey),
                Divider(
                  color: Colors.transparent,
                ),
                textFormField(
                    controller: productStockController,
                    label: 'Product Stock : ',
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (value.contains(RegExp(r'^[0-9]'))) {
                          return null;
                        } else {
                          return "Product stock should be a number only";
                        }
                      } else {
                        return "Product stock can't be empty";
                      }
                    },
                    hint: 'Enter product stock here..',
                    filledColor: Colors.grey),
                Divider(
                  color: Colors.transparent,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: appModeDark ? Colors.white : Colors.black,
                            width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size.fromHeight(40)),
                    onPressed: () {
                      if (dataEntryConstraints.currentState!.validate()) {
                        mesej = int.parse(productIdController.text);
                        setState(() {});
                      }
                    },
                    child: Text(
                      "Add Product",
                      style: TextStyle(fontSize: 17,color: appModeDark ? Colors.black : Colors.white),
                    )),
                Text("${mesej}")
              ]),
            )));
  }

  Widget textFormField(
  {required TextEditingController controller,
  required String? validator(String? value),
  required String label,
  required String hint,
  required Color filledColor}) {
return TextFormField(
style: TextStyle(
fontSize: 20, color: appModeDark ? Colors.black : Colors.white),
controller: controller,
validator: validator,
decoration: InputDecoration(
fillColor: filledColor,
filled: true,
labelStyle: TextStyle(
fontSize: 20, color: appModeDark ? Colors.black : Colors.white),
hintText: hint,
floatingLabelStyle:
TextStyle(color: appModeDark ? Colors.white60 : Colors.black),
labelText: label,
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: BorderSide(
width: 2,
color: appModeDark ? Colors.white60 : Colors.black))));
}
}
