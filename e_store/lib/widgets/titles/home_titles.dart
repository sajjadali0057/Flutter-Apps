import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeTitles extends StatelessWidget {
  String hometitles;
  homeTitles({super.key, required this.hometitles});

  @override
  Widget build(BuildContext context) {
    return Text(hometitles, style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),);
  }
}

class homeSubTitles extends StatelessWidget {
  String homesubtitles;
  homeSubTitles({super.key, required this.homesubtitles});

  @override
  Widget build(BuildContext context) {
    return Text(homesubtitles, style: TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold,).copyWith(color: Colors.black87),);
  }
}


