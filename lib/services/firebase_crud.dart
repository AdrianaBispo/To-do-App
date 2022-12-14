import 'package:cloud_firestore/cloud_firestore.dart';
//models
import '../models/response.dart';
import '../models/tasks.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Tasks');

class FirebaseCrud {
  Stream<QuerySnapshot> readTodo() {
    CollectionReference taskCollection = _collection;

    return taskCollection.snapshots();
  }

  Future<Response> addTodo(
      {required String tarefa, required String descricao}) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Task todo = Task(tarefa: tarefa, descricao: descricao);

    Map<String, dynamic> data = todo.toJson();

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added a task";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<Response> updatetask(
      {required String tarefa,
      required String descricao,
      required String todoId}) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(todoId);

    Task todo = Task(tarefa: tarefa, descricao: descricao);

    Map<String, dynamic> data = todo.toJson();

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated a task";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
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
