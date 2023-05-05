import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSelector_Practice extends StatefulWidget {
  const TabSelector_Practice.TabSelector_Practice({Key? key}) : super(key: key);

  @override
  State<TabSelector_Practice> createState() => _TabSelector_PracticeState();
}

class _TabSelector_PracticeState extends State<TabSelector_Practice> {
  // List<IconData>
  List<IconTheme> iconData = [
    Icons.home,
    Icons.trending_flat,
    Icons.trending_up_sharp,
    Icons.map,
    Icons.login,
    Icons.local_grocery_store_outlined,
    Icons.table_rows_sharp
  ]
      .map((e) => IconTheme(
          data: IconThemeData(
            size: 150,
            color: CupertinoColors.systemGreen,
          ),
          child: Icon(e)))
      .toList();

  int indexOfPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation Bar"),
      ),

      body: DefaultTabController(
          length: iconData.length,
          child: Builder(
              builder: (BuildContext context) => Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                            child: TabBarView(
                          children: iconData,
                        )),
                        Center(
                          child: TabPageSelector(
                              color: Colors.deepPurpleAccent,
                              selectedColor: Colors.amber,
                              indicatorSize: 15),
                        ),
                        Divider(),
                        ButtonBar(

                          alignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                              TabController? contr =
                              DefaultTabController.of(context);
                              if (!contr.indexIsChanging && indexOfPage > 0) {
                                indexOfPage--;
                                contr.animateTo(0);
                                indexOfPage=0;
                              }
                            }, icon: Icon(Icons.skip_previous,color: Colors.blue,
                              size: 30,))
 ,                           TextButton(
                              onPressed: () {
                                TabController? contr =
                                    DefaultTabController.of(context);
                                if (!contr.indexIsChanging && indexOfPage > 0) {
                                  indexOfPage--;
                                  contr.animateTo((indexOfPage));
                                }
                              },
                              child: Text("Previous"),
                            ),
                            TextButton(
                              onPressed: () {
                                TabController? contr =
                                    DefaultTabController.of(context);
                                if (!contr.indexIsChanging &&
                                    indexOfPage <= 6) {
                                  indexOfPage++;
                                  contr.animateTo(indexOfPage);
                                }
                              },
                              child: Text("Next"),
                            ),
                            IconButton(
                                onPressed: () {
                                  TabController? contr =
                                      DefaultTabController.of(context);

                                  if (!contr.indexIsChanging) {
                                    contr.animateTo(iconData.length-1);
                                    indexOfPage=iconData.length-1;
                                  }
                                },
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.blue,
                                  size: 30,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
