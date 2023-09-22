import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_application/home_page.dart';

import 'customs/dialoguebox.dart';

class viewTodoPage extends StatefulWidget {
  viewTodoPage({
    Key? key,
    required this.document,
    required id,
  }) : super(key: key);
  final Map<String, dynamic> document;

  @override
  State<viewTodoPage> createState() => viewTodoPageState();
}

class viewTodoPageState extends State<viewTodoPage> {
  @override
  late TextEditingController title;
  late String task;
  late TextEditingController description;
  late String category;
  bool edit = false;
  String editlabel = "Edit";
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String texttitle = widget.document["title"] ?? "No Title";
    title = TextEditingController(text: texttitle);
    String descriptiontext = widget.document["description"] == null
        ? "No Description"
        : widget.document['description'];
    description = TextEditingController(text: descriptiontext);
    task = widget.document['importance'];
    category = widget.document['category'];
    id = widget.document['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User currentuser = auth.currentUser!;
    String uid = currentuser.uid;
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("tasks")
        .doc(uid)
        .collection("mytasks")
        .doc(id);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xfff46b45), Color(0xffeea849)])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: edit ? Colors.deepPurple : Colors.white,
                            size: 28,
                          )),
                      IconButton(
                          onPressed: () async {
                            showDialog(context: context, builder: (context){

                              return dialogue(title: "Are you sure you want to delete ?", callback: (){
                                ref.delete();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => HomePage()),
                                        (route) => false);
                              }, no: () { Navigator.pop(context); },);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 28,
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingText('View'),
                    const SizedBox(
                      height: 6,
                    ),
                    headingText2('Your Todo'),
                    const SizedBox(
                      height: 16,
                    ),
                    labelText('Task Title'),
                    const SizedBox(
                      height: 8,
                    ),
                    textContainer(55, "Task Title"),
                    const SizedBox(
                      height: 20,
                    ),
                    labelText('Task Type'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Chiplabel('Important', 0xff800000),
                        const SizedBox(
                          width: 15,
                        ),
                        Chiplabel('Planned', 0xff378805)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    labelText('Description'),
                    const SizedBox(
                      height: 8,
                    ),
                    descriptionContainer(150, "Description"),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        categoryChiplabel("Food", 0xffDE3163),
                        categoryChiplabel("Workout", 0xff00cc44),
                        categoryChiplabel("Work", 0xff8a0c40),
                        categoryChiplabel("Design", 0xff355E3B),
                        categoryChiplabel("Run", 0xffff3800),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    edit
                        ? Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(colors: [
                                  Color(0xff6441A5),
                                  Color(0xff2a0845)
                                ])),
                            child: elevatedbutton(
                              ref: ref,
                              title: title,
                              task: task,
                              description: description,
                              category: category,
                              edit: edit,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText(String label) {
    return Text(
      label,
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
    );
  }

  Widget headingText(String s) {
    return Text(
      edit ? editlabel : s,
      style: const TextStyle(
          fontSize: 33,
          letterSpacing: 2,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget headingText2(String s) {
    return Text(
      s,
      style: const TextStyle(
          fontSize: 33,
          letterSpacing: 2,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget Chiplabel(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                task = label;
              });
            }
          : null,
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: task == label ? Colors.deepPurple : Color(color),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget categoryChiplabel(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: category == label ? Colors.deepPurple : Color(color),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget textContainer(double Height, String hint) {
    return Container(
      height: Height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.orangeAccent.shade100,
      ),
      child: TextField(
        enabled: edit,
        controller: title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white70, fontSize: 17),
            contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 5)),
      ),
    );
  }

  Widget descriptionContainer(double Height, String hint) {
    return SingleChildScrollView(
      child: Container(
        height: Height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.orangeAccent.shade100,
        ),
        child: TextField(
          enabled: edit,
          controller: description,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 17),
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5)),
        ),
      ),
    );
  }
}

class elevatedbutton extends StatelessWidget {
  elevatedbutton({
    super.key,
    required this.title,
    required this.task,
    required this.description,
    required this.category,
    required this.edit,
    required this.ref,
  });

  final TextEditingController title;
  final String task;
  final TextEditingController description;
  final String category;
  final bool edit;
  final ref;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.transparent),
        onPressed: () {
          var time = DateTime.now();
          ref.update({
            "title": title.text,
            "importance": task,
            "description": description.text,
            "category": category,
            'time': time.toString(),
          });

          Navigator.pop(context);
        },
        child: Text(
          edit ? "Edit Todo" : 'Add Todo',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ));
  }
}
