import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model.dart';


class firebaseUtilesBOOK {

  static CollectionReference<BookModel> getCollection(){
    return  FirebaseFirestore.instance
        .collection(BookModel.collectionName)
        .withConverter<BookModel>(
      fromFirestore: (snapshot, _) => BookModel.fromFireStore(snapshot.data()!),
      toFirestore: (event, _) => event.toFireStore(),
    );

  }
  static Future<void> addToFirebase(BookModel book){
    var collection = getCollection();
    var doc = collection.doc();
    book.id=doc.id;
    return doc.set(book);

  }
}