import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
   TodoCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.bgcolor,

      required this.time});

  final String title;
  final IconData iconData;
  final Color bgcolor;
  final String time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [

          Expanded(
            child: SizedBox(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.grey.shade900,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                            color: bgcolor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          iconData,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white),
                    )),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 15,
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
