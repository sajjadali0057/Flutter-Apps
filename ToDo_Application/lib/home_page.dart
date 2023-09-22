
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/addToDo.dart';
import 'package:todo_application/customs/dialoguebox.dart';
import 'package:todo_application/service/auth_service.dart';
import 'package:todo_application/sign_in.dart';
import 'package:todo_application/viewPage.dart';
import 'customs/todoCard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    getuid();
  }

  AuthClass authClass = AuthClass();

  getuid() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String dateformate = DateFormat.yMMMd().format(time);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(

          backgroundColor: Colors.transparent,
          title: const Text(
            "Today's Schedule",
            style: TextStyle(
                fontSize: 33, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Text(
                    dateformate,
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
             BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colors.transparent,),
                label: ""),
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => addTodoPage()));
                  },
                  child: Container(
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xff6441A5), Color(0xff2a0845)])),
                      child: const Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.white,
                      )),
                ),
                label: ""),
             BottomNavigationBarItem(
                icon: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)
                    {
                      return dialogue(title: "Are you sure you want to logout ?", callback: () {
                        final auth = FirebaseAuth.instance;
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => SignIn()),
                                (route) => false);
                      }
                          , no: (){
                            Navigator.pop(context);
                          });


                    }
                    );},
                  child: Icon(
                    Icons.logout,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                label: "")
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection("tasks")
                  .doc(uid)
                  .collection('mytasks')
                  .snapshots(),

              // StreamBuilder(
              // stream: _stream,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  {
                   return Center(
                      child: Container(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  else
                    {

                 return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      IconData iconLogo;
                      Color iconColor;
                      Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                      var id = document["id"].toString();
                      var time =DateTime.tryParse(document['time'].toString());
                      String formatted = DateFormat.yMd().format(time!);
                      switch (document["category"]) {
                        case "Work":
                          iconLogo = Icons.work;
                          iconColor = Color(0xff8a0c40);
                          break;
                        case "Food":
                          iconLogo = Icons.fastfood;
                          iconColor = Color(0xffDE3163);
                          break;
                        case "Workout":
                          iconLogo = Icons.sports_gymnastics;
                          iconColor = Color(0xff00cc44);
                          break;
                        case "Design":
                          iconLogo = Icons.design_services;
                          iconColor = Color(0xff6a329f);
                          break;
                        case "Run":
                          iconLogo = Icons.directions_run_rounded;
                          iconColor = Color(0xffff3800);
                          break;
                        default:
                          iconLogo = Icons.question_mark;
                          iconColor = Colors.transparent;
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => viewTodoPage(
                                document: document,
                                id:id,
                              ),
                            ),
                          );
                        },
                        child: TodoCard(
                          title: document["title"] == null
                              ? ""
                              : document["title"],
                          iconData: iconLogo,
                          bgcolor: iconColor,
                          time: formatted,

                        ),
                      );
                    });
              }}),
        ),
      ),
    );
  }
}
