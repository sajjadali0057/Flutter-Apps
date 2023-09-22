import 'package:flutter/material.dart';
import 'package:flutter/src/material/dialog.dart';
class dialogue extends StatefulWidget {
  dialogue({super.key, required this.title, required this.callback, required this.no});
  final VoidCallback callback;
  final VoidCallback no;
  final String title;

  @override
  State<dialogue> createState() => _dialogueState();
}

class _dialogueState extends State<dialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: Center(
        child: SizedBox(
          width: 200,
          child: Text(widget.title,textAlign: TextAlign.center,),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      buttonPadding: EdgeInsets.symmetric(horizontal: 20),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18
      ),
      actions: [
        SizedBox(
          width: 100,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange
              ),
              onPressed: widget.callback
              , child: Text('Yes')),
        ),
        SizedBox(
          width: 100,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,

              ),
              onPressed: widget.no
              , child: Text('No',style: TextStyle(color: Colors.deepOrange),)),
        ),

      ],
    );

  }
}

class dialogue2 extends StatelessWidget {
  dialogue2({super.key, required this.title, required this.callback,});
  final VoidCallback callback;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: Center(
        child: SizedBox(
          width: 200,
          child: Text(title,textAlign: TextAlign.center,),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      buttonPadding: EdgeInsets.symmetric(horizontal: 20),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18
      ),
      actions: [
        SizedBox(
          width: 100,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple
              ),
              onPressed: callback
              , child: Text('Okay')),
        ),
      ],
    );

  }

}

