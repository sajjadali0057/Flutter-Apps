import 'package:flutter/material.dart';

class emailField extends StatelessWidget {
  String emailhint = "";
  TextEditingController controller= TextEditingController();

  emailField({super.key, required this.emailhint, required this.controller});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.email_outlined,
          ),
          hintText: emailhint,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
class namefield extends StatelessWidget {
  String hint = "";
  IconData icon ;
  TextInputType type;
  TextEditingController controller= TextEditingController();

   namefield({super.key, required this.hint, required this.icon, required this.controller, required this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}


class passwordField extends StatefulWidget {
  String hint;
  TextEditingController controller= TextEditingController();
  passwordField({
    super.key,
    required this.hint,
    required this.controller

  });



  @override
  State<passwordField> createState() => _passwordFieldState();
}
class _passwordFieldState extends State<passwordField> {
  bool show = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      cursorColor: Colors.grey,
      obscureText: show,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          hintText: widget.hint,

          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            child: const Icon(Icons.remove_red_eye),
          )),
    );

  }
}
