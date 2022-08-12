import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';

class RestaurantFoodMenu extends StatefulWidget {
  final menuList;

  const RestaurantFoodMenu({Key key, this.menuList}) : super(key: key);
  @override
  _RestaurantFoodMenuState createState() => _RestaurantFoodMenuState();
}

class _RestaurantFoodMenuState extends State<RestaurantFoodMenu> {
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
          .collection('Restaurant')
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
                                                  .collection('Restaurant')
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tap to see food content',
                          style: TextStyle(color: Colors.blueGrey),
                        )),
                  ),
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
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    height: 200,
                                    child: ListView(
                                      children: [
                                        ListTile(
                                            title: Text(
                                          'Contents',
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        )),
                                        ListTile(
                                          title: Text(
                                            ((doc[index].data()['contents'] !=
                                                    null)
                                                ? doc[index].data()['contents']
                                                : 'Contents not provided'),
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: ButtonTheme(
                                              minWidth: 30,
                                              child: FlatButton(
                                                child: Text(
                                                  'Okay',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              });
                        },
                        onLongPress: () {},
                        leading: Icon(
                          Linecons.food,
                          color: Colors.amber[900],
                        ),
                        title: Text("${doc[index].data()['foodName']}"),
                        subtitle: Text("${doc[index].data()['price']} Br."),
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
