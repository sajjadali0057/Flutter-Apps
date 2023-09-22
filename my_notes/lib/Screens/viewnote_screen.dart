
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:quickalert/quickalert.dart';

class viewNote extends StatefulWidget {
  const viewNote({
    Key? key,
    required this.document,
    required id,
  }) : super(key: key);

  final Map<String, dynamic> document;

  @override
  State<viewNote> createState() => viewNoteState();
}

class viewNoteState extends State<viewNote> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    String title = widget.document['title'].toString();
    String note = widget.document['note'].toString();
    var time =DateTime.tryParse(widget.document['time'].toString());
    String id = widget.document['id'].toString();
    String formatedtime = DateFormat.yMd().format(time!);
    final finaltime = "Edited $formatedtime";

    late TextEditingController titletext;
    late TextEditingController notetext;

    titletext = TextEditingController(text: title);
    notetext = TextEditingController(text: note);
    final auth = FirebaseAuth.instance;
    final currentuser = auth.currentUser!;
    String uid = currentuser.uid;

    final ref = FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection('userinformation')
        .doc(uid)
        .collection('userdata')
        .doc(id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Center(child: Text("Your Note")),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffBE5869), Color(0xff403A3E)]),
                border: Border(),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                  });
                  ref
                      .update({
                    'title': titletext.text,
                    "note": notetext.text,
                    'time': DateTime.now().toString()
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check)),
            IconButton(
                onPressed: () {
             QuickAlert.show(context: context,
                 type: QuickAlertType.confirm,
               text: "Are You Sure ?",
                 title: "Delete",
               confirmBtnColor:
               Colors.black87,
               barrierColor: Colors.black87,
               onConfirmBtnTap: (){
               ref.delete();
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const homeScreen()), (route) => false);
               },
             );
            }, icon: const Icon(Icons.delete))
          ],
        ),
        body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black87),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: titletext,
                              enabled: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              maxLength: null,
                                maxLines: null,
                                enabled: true,
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                controller: notetext,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.bottomRight,
                              child: Text(
                                  finaltime,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.clip,
                                      fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                ),
              ),
            )));
  }
}
