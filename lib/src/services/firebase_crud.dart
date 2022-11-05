import 'package:cloud_firestore/cloud_firestore.dart';
//models
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Tasks');

class FirebaseCrud {
  Stream<QuerySnapshot> readTodo() {
    CollectionReference taskCollection = _collection;

    return taskCollection.snapshots();
  }


  Future<Response> deleteTodo({required String todoId}) async {
    Response response = Response();

    DocumentReference documentReferencer = _collection.doc(todoId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = 'You deleted a task';
    }).catchError((e) {
           response.code = 500;
            response.message = e;
        });
    return response;
  }
}
