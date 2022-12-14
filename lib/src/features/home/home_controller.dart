import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_crud.dart';
//models
import '../../shared/models/response.dart';

class HomeController {
  FirebaseCrud firebasecrud;
  HomeController({required this.firebasecrud});

  Stream<QuerySnapshot> read() {
    return firebasecrud.readTodo();
  }
  Future<Response> add({required String tarefa, required String descricao}){
    return firebasecrud.addTodo(tarefa: tarefa, descricao: descricao);
  }

  Future<Response> update(
      {required String tarefa,
      required String descricao,
      required String todoId}) async {
    Response response = await firebasecrud.updatetask(
        tarefa: tarefa, descricao: descricao, todoId: todoId);
        return response;
  }

  Future<Response> delete({required String todoId}) async {
    Response response = await firebasecrud.deleteTodo(todoId: todoId);

    return response;
  }
}
