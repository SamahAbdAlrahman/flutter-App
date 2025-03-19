import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/data/event_model.dart';
import 'package:new_flutter_app/model.dart';

import 'firebaseFun.dart';


class GetUsersPage extends StatefulWidget {
  @override
  _GetUsersPageState createState() => _GetUsersPageState();
}

class _GetUsersPageState extends State<GetUsersPage> {
  List dataBooksArray = [];
  var nameController=TextEditingController() ;
  var authController=TextEditingController() ;
  @override
  void initState() {
    super.initState();
    get();
  }
  void get() async{
    QuerySnapshot<BookModel> books=await firebaseUtilesBOOK.getCollection().get();
    dataBooksArray=books.docs.map((doc){
      return doc.data();
    }).toList();
    setState(() {
    });
  }

  Future<void> addData() async{
      BookModel book=BookModel(

      name: nameController.text,
      auth: nameController.text,
    );
      firebaseUtilesBOOK.addToFirebase(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("data"),),
      body: Column(
        children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "enter name",
                ),

              ),
              TextFormField(
                controller: authController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "enter auth name",
                ),

              ),
              ElevatedButton(
                  onPressed: (){
                    addData();
                    setState(() {

                    });
                  },
                  child: Text("submit"),
              ),

          Expanded(
            child: GridView.builder(
              itemCount: dataBooksArray.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Name: ${dataBooksArray[index].name}"),
                  subtitle: Text("Age: ${dataBooksArray[index].auth}"),
            
            
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
