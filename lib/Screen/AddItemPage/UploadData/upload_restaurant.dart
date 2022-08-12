import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadRestaurant extends StatefulWidget {
  @override
  _UploadRestaurantState createState() => _UploadRestaurantState();
}

class _UploadRestaurantState extends State<UploadRestaurant> {
  final formKey = GlobalKey<FormState>();
  String type;
  String restaurantName;
  String distance;

  File image1;
  File file;
  String email;
  String facebook;
  String instagram;
  String imageUrl;
  String phone;
  String description;

  final imagePicker = ImagePicker();

  var currentSelectedValue1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              uploadImageandSaveItem();
            },
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Restaurant',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white12,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: formKey,
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
                    height: 20,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Business Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      this.restaurantName = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Phone number(optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      this.phone = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // TextField(
                  //   textInputAction: TextInputAction.next,
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     hintText: 'Email(optional)',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   onChanged: (value) {
                  //     this.email = value;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Facebook(optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      this.facebook = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Instagram(optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      this.instagram = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonTheme(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null ? 'Enter type' : null,
                        value: currentSelectedValue1,
                        hint: Text('Type'),
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedValue1 = newValue;
                            this.type = newValue;
                          });
                        },
                        items: <String>[
                          'Restaurant',
                          'Cafe',
                          'Burger&Pizza',
                          'Fasting',
                          'Pasta',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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
    if (formKey.currentState.validate()) {
      // setState(() => isLoading = true);
      if (restaurantName != null) {
        if (type.isNotEmpty) {
          saveItem(imageDownloadUrl);

          formKey.currentState.reset();
          // setState(() => isLoading = false);
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Posted'),
                    content: const Text('Food uploaded succesfully'),
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
                title: Text('Enter type'),
              );
            });
        //setState(() => isLoading = false);
        // Fluttertoast.showToast(msg: 'Enter a price');
      }
    }
  }

  Future<String> uploadItemImage(file) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("restaurant");

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
    final itemsRef = FirebaseFirestore.instance.collection('Restaurant');

    itemsRef.doc(restaurantName).set(
      {
        'name': restaurantName,
        // 'email': email,
        'type': type,
        'phone': phone,
        'instagram': instagram,
        'facebook': facebook,
        'image': imageDownloadUrl,
      },
    );
  }
}
