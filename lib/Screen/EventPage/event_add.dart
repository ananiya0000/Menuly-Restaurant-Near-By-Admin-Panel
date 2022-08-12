import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EventAdd extends StatefulWidget {
  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  String imageDownloadUrl;

  DateTime selectedDate = DateTime.now();
  String name;
  File image1;
  DateTime date;
  final formkey = GlobalKey<FormState>();
  File file;
  String price;
  final imagePicker = ImagePicker();
  String eventDetail;
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Add an event',
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              OutlineButton(
                  onPressed: () {
                    getImage();
                  },
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  child: (image1 != null)
                      ? Container(
                          height: 200,
                          child: Image.file(
                            image1,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 26, 8.0, 26),
                          child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                getImage();
                              }),
                        )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      this.name = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Event name')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: priceController,
                    onChanged: (value) {
                      this.price = value;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Price')),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: OutlineButton.icon(
              //       icon: Icon(Icons.calendar_today_outlined),
              //       label: Text('Event date'),
              //       onPressed: () {
              //         _selectDate(context);
              //         // this.date=
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: detailController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      this.eventDetail = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Event detail')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  height: 50,
                  minWidth: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      uploadImageandSaveItem();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Upload was successful'),
                              actions: [
                                FlatButton(
                                    child: Text('Okay'), onPressed: () {}),
                              ],
                            );
                          });
                      Navigator.pop(context);
                      priceController.clear();
                      nameController.clear();
                      detailController.clear();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image1 = File(image.path);
    });
  }

  // ignore: missing_return
  Future<String> uploadImageandSaveItem() async {
    String imageDownloadUrl = await uploadItemImage(image1);
    if (formkey.currentState.validate()) {
      // setState(() => isLoading = true);
      if (name != null) {
        if (price.isNotEmpty) {
          saveItem(imageDownloadUrl);

          formkey.currentState.reset();
          // setState(() => isLoading = false);
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Posted'),
                    content: const Text('Event uploaded succesfully'),
                    actions: [
                      FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Unable to post item'),
                );
              });
          /* setState(() => isLoading = false);
          Fluttertoast.showToast(msg: 'Enter a name');
          Fluttertoast.showToast(
              msg: 'Food added to menu', backgroundColor: Colors.black);*/
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter price'),
              );
            });
        //setState(() => isLoading = false);
        // Fluttertoast.showToast(msg: 'Enter a price');
      }
    }
  }

  Future<String> uploadItemImage(file) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Tickets");

    StorageUploadTask task = storageReference
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image1);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  saveItem(imageDownloadUrl) {
    var id = Uuid();
    String productId = id.v1();
    final itemsRef = FirebaseFirestore.instance.collection('Tickets');

    itemsRef.doc(name).set(
      {
        'ticketName': name,
        'price': price,
        'details': eventDetail,
        'image': imageDownloadUrl,
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
