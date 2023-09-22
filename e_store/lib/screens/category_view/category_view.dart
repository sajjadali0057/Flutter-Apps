import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/firebase_helper/firebasefirestore_helper/firebase_firestore_helper.dart';

import 'package:flutter/material.dart';
import '../../constants/circularindicator.dart';
import '../../constants/routes.dart';
import '../../models/categories_view_model.dart';
import '../../models/category_model.dart';
import '../../models/category_model.dart';
import '../../models/category_model.dart';
import '../../widgets/product_gridview/product_gridview.dart';
import '../../widgets/titles/home_titles.dart';
import '../cart_screen/cart_screen.dart';
import '../home/home_page.dart';
import '../product_details/product_details.dart';

class categoryView extends StatefulWidget {
  categoryView({super.key, required this.categoryViewModel});
  final CategoryModel categoryViewModel;

  @override
  State<categoryView> createState() => _categoryViewState();
}
class _categoryViewState extends State<categoryView> {
  List<CategoryViewModel> CategoryViewList = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetCategoryView();
  }
  void GetCategoryView() async {
    setState(() {
      loading = true;
    });
    CategoryViewList = await FirebaseFirestoreHelper.instance
        .getCategoryView(widget.categoryViewModel.id);
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Container(
                child: Center(
                  child: showCircular(),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kToolbarHeight *1,
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_ios)),
                              homeTitles(hometitles: widget.categoryViewModel.name),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ProductGridView(CategoryViewList: CategoryViewList),
                          const SizedBox(
                            height:
                            kBottomNavigationBarHeight,
                          )
                        ]))));
  }
}

