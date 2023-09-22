import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_screen.dart';

class addNote extends StatefulWidget {
  const addNote({super.key});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  final titlecontroller = TextEditingController();
  final notecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(color: Colors.black87),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    try {
                                      if (notecontroller.toString() != null) {
                                        addCollectionToDb();
                                      } else {

                                        SnackBar snackBar = const SnackBar(
                                            content: Text(
                                                "Please write something in the note"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      SnackBar snackBar =
                                          SnackBar(content: Text(e.toString()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          TextField(
                            controller: titlecontroller,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Title",
                                hintStyle: TextStyle(
                                    fontSize: 30, color: Colors.white70)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              maxLines: null,
                              maxLength: null,
                              controller: notecontroller,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "What's in your mind?",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }

  void addCollectionToDb() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User currentUser = auth.currentUser!;
    final uid = currentUser.uid;
    var time = DateTime.now().millisecondsSinceEpoch.toString();

    var time2 = DateTime.now().toString();
    var docid = time;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userinformation')
        .doc(uid)
        .collection('userdata')
        .doc(time)
        .set({
      'title': titlecontroller.text,
      'note': notecontroller.text,
      "time": time2,
      'id': docid
    }).then((value) {
      SnackBar snackBar = const SnackBar(content: Text("Note Saved"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => homeScreen()),
          (route) => false);
    }).onError((error, stackTrace) {
      SnackBar snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
