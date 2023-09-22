
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/Screens/addnote_screen.dart';
import 'package:my_notes/Screens/signin_screen.dart';
import 'package:my_notes/Screens/viewnote_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class homeScreen extends StatefulWidget {
  const homeScreen( {Key? key}): super(key : key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    String? uid = currentUser?.uid;

    setState(() {
    });
    final firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("userinformation")
        .doc(uid)
        .collection('userdata')
        .snapshots();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffBE5869), Color(0xff403A3E)]),
                    border: Border(),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
              ),
              title: const Center(child: Text('Add Note')),
              actions: [
                IconButton(
                    onPressed: () {
                      QuickAlert.show(context: context,
                        type: QuickAlertType.confirm,
                        text: "Are You Sure ?",
                        title: "Logout",
                        confirmBtnColor:
                        Colors.black87,
                        barrierColor: Colors.black87,
                        confirmBtnText: 'Logout',
                        onConfirmBtnTap: (){
                          FirebaseAuth auth = FirebaseAuth.instance;
                          auth.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const signIn()),
                                  (route) => false);
                        },


                      );


                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const addNote()));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffBE5869), Color(0xff403A3E)]),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.add)),
            ),

                body: Container(
                    decoration: const BoxDecoration(color: Colors.black87),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: StreamBuilder(
                          stream: firestore,
                          builder: (BuildContext context,
                              snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                             return Center(
                               child: SizedBox(
                                 height: 50,
                                 width: 50,
                                 child: CircularProgressIndicator(
                                   color: Colors.black54,
                                 ),
                               ),
                             );
                            }
                            else{
                              return GridView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> document =
                                  snapshot.data?.docs[index].data()
                                  as Map<String, dynamic>;
                                  var id = document['id'].toString();
                                  var time = DateTime.tryParse(document['time'].toString(),);
                                  String formatedtime = DateFormat.yMd().format(time!);

                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> viewNote(document:document,id:id)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        border: Border.all(
                                            color: Colors.white54, width: 0.5),
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20,),
                                            Text(
                                              document['title'].toString(),
                                              style:
                                              const TextStyle(color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Expanded(

                                              child: Text(

                                                  document['note'].toString(),
                                                  style: const TextStyle(

                                                    color: Colors.white,
                                                  )),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                  formatedtime,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      overflow:
                                                      TextOverflow.clip)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: (100 / 150)),
                              );
                            }

                          }),
                    ))));
  }
}
