import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RestaurantService {
  String collection = "Restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'Restaurant';

  Future<void> uploadProduct({
    String name,
    String distance,
    String email,
    String facebook,
    String instagram,
    String phone,
    String type,
    String description,
    String image,
  }) async {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).doc(productId).set({
      'name': name,
      'distance': distance,
      'description': description,
      'image': image,
      'facebook': facebook,
      'phone': phone,
      'type': type,
      'instagram': instagram,
    });
  }
}
