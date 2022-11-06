import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import '../../models/tasks.dart';
//controller
import '../../controller/home_controller.dart';
//services
import '../../services/firebase_crud.dart';
//UI
import '../../models_ui/textitle_model.dart';
import '../../models_ui/subtitle_model.dart';
import '../../models_ui/texfield_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subController = TextEditingController();
  HomeController controller = HomeController(firebasecrud: FirebaseCrud());

  CollectionReference todoss = FirebaseFirestore.instance.collection('Tasks');

  Future _create() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          color: const Color(0xffE0E0E0),
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextfieldModel(
                  textController: _nameController,
                  labelText: _nameController.text,
                ),
                TextfieldModel(
                  textController: _subController,
                  labelText: 'Description',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff01B59F),
                    elevation: 0,
                    minimumSize: const Size(120, 45),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffFAFAFA),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? sub = _subController.text;
                    if (name != null && sub != null) {
                      var response =
                          await controller.add(tarefa: name, descricao: sub);
                      if (response.code != 200) {
                        //Show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xffE0E0E0),
                            content: Text(
                              response.message.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 15.0,
                                color: const Color(0xff2D3A4A),
                              ), // style
                              textAlign: TextAlign.left,
                            ),
                          ),
                        );
                      }
                    }

                    // Clear the text fields
                    _nameController.text = '';
                    _subController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _update(
      {required String tarefa,
      required String descricao,
      required String todoId}) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: const Color(0xffE0E0E0),
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextfieldModel(
                    textController: _nameController,
                    labelText: _nameController.text,
                  ),
                  TextfieldModel(
                    textController: _subController,
                    labelText: 'Description',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff01B59F),
                      elevation: 0,
                      minimumSize: const Size(120, 45),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffFAFAFA),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    onPressed: () async {
                      final String? name = _nameController.text;
                      final String? sub = _subController.text;
                      if (name != null && sub != null) {
                        var response = await controller.update(
                            tarefa: tarefa,
                            descricao: descricao,
                            todoId: todoId);

                        if (response.code != 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xffE0E0E0),
                              content: Text(
                                response.message.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  color: const Color(0xff2D3A4A),
                                ), // style
                                textAlign: TextAlign.left,
                              ),
                            ),
                          );
                        }
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _subController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Deletando tarefa pelo id
  Future<void> _deleteTodo(String todoId) async {
    var response = await controller.delete(todoId: todoId);

    if (response.code != 200) {
      //Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xffE0E0E0),
          content: Text(
            response.message.toString(),
            style: GoogleFonts.montserrat(
              fontSize: 15.0,
              color: const Color(0xff2D3A4A),
            ), // style
            textAlign: TextAlign.left,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: const Color(0xffFAFAFA),
        title: Text(
          "NotApp",
          style: GoogleFonts.montserrat(
              fontSize: 28, color: const Color(0xff2D3A4A)),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: StreamBuilder(
          stream: controller.read(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () => _create(
                          tarefa: documentSnapshot['tarefa'],
                          descricao: documentSnapshot['descricao'],
                        ),
                        child: Container(
                          height: 70,
                          margin: const EdgeInsets.only(
                              bottom: 2.3, top: 5.2, left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xffE0E0E0),
                            border: Border.all(
                              width: 5,
                              color: const Color(0xffE0E0E0),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .6,
                                child: ListTile(
                                  title: TextitleModel(
                                    texto: documentSnapshot['tarefa'],
                                  ),
                                  subtitle: SubTitleModel(
                                    texto: documentSnapshot['descricao'],
                                  ),
                                ),
                              ),

                              // Deletar
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: const Color(0xff233C5B),
                                onPressed: () =>
                                    _deleteTodo(documentSnapshot.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color(0xffE0E0E0),
                backgroundColor: Color(0xffFAFAFA),
              ));
            } else {
              return Center(child: Text(snapshot.error.toString()));
            }
          }),

      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        backgroundColor: const Color(0xff01B59F),
        child: const Icon(
          Icons.add,
          color: Color(0xffE0E0E0),
        ),
      ),
    );
  }
}
