import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_crud.dart';
//models
import '../models/response.dart';

class HomeController {
  FirebaseCrud firebasecrud;
  HomeController({required this.firebasecrud});

  Stream<QuerySnapshot> read() {
    return firebasecrud.readTodo();
  }

  Future<Response> delete({required String todoId}) async {
    Response response = await firebasecrud.deleteTodo(todoId: todoId);

    return response;
  }
}
