import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteData {
  deleteRestaurantData(docId) {
    FirebaseFirestore.instance
        .collection('Restaurant')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteHotelData(docId) {
    FirebaseFirestore.instance
        .collection('Hotels')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteHospitalData(docId) {
    FirebaseFirestore.instance
        .collection('Hospital')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteEntertainmentData(docId) {
    FirebaseFirestore.instance
        .collection('Entertainment')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteShoppingData(docId) {
    FirebaseFirestore.instance
        .collection('Shopping')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
  // deleteMenuData(docId) {
  //   FirebaseFirestore.instance

  //         .collection('Restaurant')
  //         .doc(doc[index].documentID)
  //         .collection('Menu')
  //         .snapshots();
  //   }
  // }

  deleteTicketData(docId) {
    FirebaseFirestore.instance
        .collection('Tickets')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
