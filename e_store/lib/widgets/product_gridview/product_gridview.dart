import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../models/categories_view_model.dart';
import '../../screens/product_details/product_details.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.CategoryViewList,
  });

  final List<CategoryViewModel> CategoryViewList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: CategoryViewList.length,
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
          CategoryViewModel singleProduct =
          CategoryViewList[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.withOpacity(0.3),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
                        Image.network(
                          singleProduct.image,
                          width: 100,
                          height: 80,
                        ),
                        Container(
                          height: MediaQuery.of(
                              context)
                              .size
                              .aspectRatio +
                              10,
                        ),
                        Text(
                          singleProduct.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
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
                              fontSize: 12,
                              color: Colors.black54),
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
                          BorderRadius.circular(6)),
                      child: OutlinedButton(
                        onPressed: () {
                          Routes().Push(
                              context: context,
                              widget: ProductDetails(
                                singleProduct:
                                singleProduct,
                              ));
                        },
                        child: const Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.deepOrange),
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
        });
  }
}
