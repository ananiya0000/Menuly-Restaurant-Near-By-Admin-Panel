import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';

class CafeFoodMenu extends StatefulWidget {
  final menuList;

  const CafeFoodMenu({Key key, this.menuList}) : super(key: key);
  @override
  _CafeFoodMenuState createState() => _CafeFoodMenuState();
}

class _CafeFoodMenuState extends State<CafeFoodMenu> {
  String foodName;
  String price;
  String contents;

  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stream items;

    TextEditingController contentController = new TextEditingController();
    GetData crudObj = new GetData();

    final db = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('Cafes')
          .doc(widget.menuList)
          .collection('Menu')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text('Add a food'),
                            content: Wrap(
                                /* margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),*/
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            controller: nameController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            onChanged: (value) {
                                              this.foodName = value;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Food name')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            controller: priceController,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              this.price = value;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Price')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                            controller: contentController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            maxLines: 3,
                                            onChanged: (value) {
                                              this.contents = value;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Contents(optional)')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonTheme(
                                          height: 50,
                                          minWidth: double.infinity,
                                          child: RaisedButton(
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('Cafes')
                                                  .doc(widget.menuList)
                                                  .collection('Menu')
                                                  .doc(foodName)
                                                  .set({
                                                'foodName': foodName,
                                                'price': price,
                                                'contents': contents,
                                              });
                                              nameController.clear();
                                              priceController.clear();
                                              contentController.clear();
                                              /*  showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Upload was succesful'),
                                                      actions: [
                                                        FlatButton(
                                                            child: Text('Okay'),
                                                            onPressed: () {}),
                                                      ],
                                                    );
                                                  });*/
                                              // Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ));
                },
                child: Icon(Icons.add, color: Colors.white)),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     child: Text(
                  //       'Menu',
                  //       style:
                  //           TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  //     ),
                  //     alignment: Alignment.topLeft,
                  //   ),
                  // ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data.docs;
                      return ListTile(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Contents'),
                              content: Text('${doc[index].data()['contents']}'),
                              actions: [
                                FlatButton(
                                    child: Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          );
                        },
                        leading: Icon(
                          Linecons.food,
                          color: Colors.amber[900],
                        ),
                        title: Text("${doc[index].data()['foodName']}"),
                        subtitle: Text(
                            "${doc[index].data()['price']} Br.\n${doc[index].data()['contents']}"),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
