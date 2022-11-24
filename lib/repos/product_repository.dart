import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterbloc/models/model.dart';

class ProductRepository{
  final _fireCloud = FirebaseFirestore.instance.collection("products"); ///Collection created in firestore


  ///Method we'll call from our UI
  Future<void> create({required String name, required String price}) async {
    try{
      await _fireCloud.add({"name": name, "price": price}); ///Posts data to the server
    } on FirebaseException catch (e) {
      if(kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> update({required String name, required String price, required DocumentSnapshot doc}) async {
    final proCollection = FirebaseFirestore.instance.collection("products");
    final proRef = proCollection.doc(doc.id);

    try{
      await proRef.update({"name": name, "price":price}); ///Posts data to the server
    } on FirebaseException catch (e) {
      if(kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> get() async {

    List<ProductModel> proList = [];

    try {
      final pro = await FirebaseFirestore.instance.collection("products").get();

      pro.docs.forEach((element) {
        return proList.add(ProductModel.fromJson(element.data()));
      });

      return proList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}

