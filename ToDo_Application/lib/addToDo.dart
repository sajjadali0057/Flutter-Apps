import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addTodoPage extends StatefulWidget {
  addTodoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<addTodoPage> createState() => addTodoPageState();
}

class addTodoPageState extends State<addTodoPage> {
  @override
  TextEditingController title = TextEditingController();
  String task = "";
  TextEditingController description = TextEditingController();
  String category = "";

  Widget build(BuildContext context) {
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
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingText('Create'),
                    const SizedBox(
                      height: 6,
                    ),
                    headingText('New Todo'),
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
                    Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(colors: [
                              Color(0xff6441A5),
                              Color(0xff2a0845)
                            ])),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              addTaskFirebase();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Add Todo',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            )))
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
      onTap: () {
        setState(() {
          task = label;
        });
      },
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
      onTap: () {
        setState(() {
          category = label;
        });
      },
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
  addTaskFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User currentuser = await auth.currentUser!;
    var time = DateTime.now().millisecondsSinceEpoch;
    var time2 = DateTime.now().toString();
    var id = time.toString();
    String uid = currentuser.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid)
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(id)
        .set({
      'title': title.text,
      'importance': task,
      'description': description.text,
      'category': category,
      'time': time2,
      'id': id,
    });
  }
}
