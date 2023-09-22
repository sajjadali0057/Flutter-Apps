import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/routes.dart';
import 'package:e_store/firebase_helper/firebasefirestore_helper/firebase_firestore_helper.dart';
import 'package:e_store/models/product_model.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/category_view/category_view.dart';
import 'package:e_store/screens/product_details/product_details.dart';
import 'package:e_store/widgets/titles/home_titles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final searchController = TextEditingController();
  bool loading = false;
  List<CategoryModel> categoriesList = [];
  List<ProductModel> topSellingList = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoriesList();
    getTopSellingList();
    getUserInformation();
  }

  List<ProductModel> searchList = [];

  void searchProduct(String value) {
    searchList = topSellingList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  void getUserInformation() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
  }

  void getCategoriesList() async {
    setState(() {
      loading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    categoriesList.shuffle();
    setState(() {
      loading = false;
    });
  }

  void getTopSellingList() async {
    setState(() {
      loading = true;
    });
    topSellingList = await FirebaseFirestoreHelper.instance.getTopSelling();
    topSellingList.shuffle();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? const Center(
                child: showCircular(),
              )
            : SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: kToolbarHeight + 22,
                            ),
                            homeTitles(hometitles: "Easy Shopping"),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: search,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              onChanged: (String value) {
                                searchProduct(value);
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                  ),
                                  hintText: "Search...",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            search.text.isNotEmpty && searchList.isEmpty
                                ? const Center(
                                    child: Text("No Item Found"),
                                  )
                                : search.text.isNotEmpty
                                    ? GridView.builder(
                                        itemCount: searchList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        padding: EdgeInsets.zero,
                                        physics: const ScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.75,
                                        ),
                                        itemBuilder: (context, index) {
                                          ProductModel singleProduct =
                                              searchList[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.deepOrange
                                                  .withOpacity(0.3),
                                            ),
                                            child: Wrap(children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child: Image.network(
                                                          singleProduct.image,
                                                          width: 120,
                                                          height: 100,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            singleProduct.name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Price: \$${singleProduct.price}",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio +
                                                            140,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio +
                                                            40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Routes().Push(
                                                                context:
                                                                    context,
                                                                widget:
                                                                    ProductDetails(
                                                                  singleProduct:
                                                                      singleProduct,
                                                                ));
                                                          },
                                                          child: const Text(
                                                            "Buy",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .deepOrange),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            kBottomNavigationBarHeight,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          );
                                        })
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            homeSubTitles(
                                                homesubtitles: "Categories"),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 10),
                                              child: Row(
                                                  children: categoriesList
                                                      .map(
                                                        (e) => InkWell(
                                                          onTap: () {
                                                            Routes.instance
                                                                .Push(
                                                                    context:
                                                                        context,
                                                                    widget:
                                                                        categoryView(
                                                                      categoryViewModel:
                                                                          e,
                                                                    ));
                                                          },
                                                          child: Card(
                                                            color: Colors.white,
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              height: 100,
                                                              width: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Center(
                                                                  child: Image
                                                                      .network(
                                                                    e.image,
                                                                    scale: 4,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList()),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            homeSubTitles(
                                              homesubtitles: "Top Selling",
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            GridView.builder(
                                                itemCount:
                                                    topSellingList.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                padding: EdgeInsets.zero,
                                                physics: const ScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20,
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            (2 / 3)),
                                                itemBuilder: (context, index) {
                                                  ProductModel singleProduct =
                                                      topSellingList[index];
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.deepOrange
                                                          .withOpacity(0.3),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0,
                                                                horizontal: 15),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  child: Image
                                                                      .network(
                                                                    singleProduct
                                                                        .image,
                                                                    width: 100,
                                                                    height: 80,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .aspectRatio +
                                                                      10,
                                                                ),
                                                                Text(
                                                                  singleProduct
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .aspectRatio +
                                                                      5,
                                                                ),
                                                                Text(
                                                                  "Price: \$${singleProduct.price}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: double
                                                                      .maxFinite -
                                                                  30,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .aspectRatio +
                                                                  45,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  Routes().Push(
                                                                      context:
                                                                          context,
                                                                      widget:
                                                                          ProductDetails(
                                                                        singleProduct:
                                                                            singleProduct,
                                                                      ));
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Buy",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepOrange),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .aspectRatio +
                                                                  20,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            const SizedBox(
                                              height:
                                                  kBottomNavigationBarHeight,
                                            )
                                          ])
                          ],
                        ))),
              ));
  }
}

// List<String> categoriesList = [
//   "https://clipart-library.com/2023/showcase-smartphone-thumb49.png",
//   "https://img.freepik.com/free-icon/television_318-233482.jpg",
//   "https://freepngimg.com/thumb/laptop/162431-laptop-vector-notebook-png-free-photo-thumb.png",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoapN3namknpC4l0bS6Pi56uwK3YzXwc00dA&usqp=CAU",
//   "https://se.nothing.tech/cdn/shop/products/clearcase1600x2160clear_a.png?v=1658477420"
//   // "assets/vectors/tv.png",
//   // "assets/vectors/laptop.png",
//   // "assets/vectors/headphone.png",
//   // "assets/vectors/cover.png",
// ];

// List<TopSellingModel> topSelling = [
//   TopSellingModel(
//       id: "1",
//       image: "assets/products/iphone.jpg",
//       name: "Iphone 14",
//       price: "1000\$",
//       description:
//           "Iphone 14 series is the latest mobile phone series by apple",
//       status: "Pending",
//       isFavourite: false),
//   TopSellingModel(
//       id: "2",
//       image: "assets/products/samsung.jpg",
//       name: "S23 Ultra",
//       price: "1000\$",
//       description:
//           "Samsung S23 series is the latest mobile phone series by samsung",
//       status: "Pending",
//       isFavourite: false),
//   TopSellingModel(
//       id: "3",
//       image: "assets/products/ugreen.jpg",
//       name: "Ugreen Charger",
//       price: "50\$",
//       description: "65w fast charger",
//       status: "Pending",
//       isFavourite: false),
//   TopSellingModel(
//       id: "4",
//       image: "assets/products/iphonecase.jpg",
//       name: "Iphone 14 Case",
//       price: "30\$",
//       description: "Black aesthetic case",
//       status: "Pending",
//       isFavourite: false),
//   TopSellingModel(
//       id: "5",
//       image: "assets/products/headphone.jpg",
//       name: "Beats Headphone",
//       price: "70\$",
//       description: "Wireless Headphone",
//       status: "Pending",
//       isFavourite: false),
//   TopSellingModel(
//       id: "6",
//       image: "assets/products/hp.jpg",
//       name: "Hp Victus",
//       price: "1400\$",
//       description: "Core i7 Laptop",
//       status: "Pending",
//       isFavourite: false),
// ];

addtask() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection("Products")
      .doc()
      .collection("TopSelling")
      .doc()
      .set({
    "id": "1",
    "name": "HP Victus",
    "price": "1400\$",
    "description": "HP Victus",
    "status": "Pending",
    "isFavourite": false,
    "image": "assets/products/hp.jpg"
  });
}
