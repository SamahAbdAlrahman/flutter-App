import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/event_model.dart';

class firebaseUtiles {

  static CollectionReference<EventModel> getEventCollection(){
       return  FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
      fromFirestore: (snapshot, _) => EventModel.fromFireStore(snapshot.data()!),
      toFirestore: (event, _) => event.toFireStore(),
    );

  }
  static Future<void> addEventToFirebase(EventModel event){
    var collection = getEventCollection();
    var doc = collection.doc();
    event.id=doc.id;
    return doc.set(event);

  }
}