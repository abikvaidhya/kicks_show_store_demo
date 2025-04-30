import 'package:demo_task/controller/cart_controller.dart';
import 'package:demo_task/controller/product_controller.dart';
import 'package:demo_task/view/product_reviews_screen.dart';
import 'package:demo_task/view/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    this.fromDashboard = true,
  });

  final bool fromDashboard;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = Get.find<ProductController>();
  CartController cartController = Get.find<CartController>();
  UIUtils uiUtils = UIUtils();

  int picIndex = 0, sizeIndex = 0, attributeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // resetting values
    productController.quantityController(TextEditingController(text: '1'));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: customAppBar(title: '', showAction: widget.fromDashboard),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/backgrounds/dark_green.jpg',
                ),
                opacity: 0.2,
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              spacing: 20,
              children: [
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox.shrink(),
                    // product image
                    Center(
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: productController
                                  .currentProduct!
                                  .value
                                  .attribute[productController
                                      .activeProductAttributeIndex.value]
                                  .image
                                  .length,
                              pageSnapping: true,
                              onPageChanged: (page) {
                                setState(() {
                                  picIndex = page;
                                });
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: uiUtils.cachedImage(
                                    url: productController
                                        .currentProduct!
                                        .value
                                        .attribute[productController
                                            .activeProductAttributeIndex.value]
                                        .image[index],
                                  ),
                                );
                              },
                            ),
                            // pagination for images and colors
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 30,
                                  child: Row(
                                    children: [
                                      // image pagination
                                      Expanded(
                                          child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productController
                                            .currentProduct!
                                            .value
                                            .attribute[productController
                                                .activeProductAttributeIndex
                                                .value]
                                            .image
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Icon(
                                              Icons.circle,
                                              color: (picIndex == index)
                                                  ? Colors.black
                                                  : Colors.grey,
                                              size: 10,
                                            ),
                                          );
                                        },
                                      )),

                                      // colors pagination
                                      Card(
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: productController
                                                  .currentProduct!
                                                  .value
                                                  .attribute
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                List colorKeys =
                                                    productController
                                                        .currentProduct!
                                                        .value
                                                        .attribute
                                                        .map((e) => e.color)
                                                        .toList();

                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      attributeIndex = index;
                                                    });
                                                    productController
                                                        .activeProductAttributeIndex(
                                                            attributeIndex);
                                                    picIndex = 0;
                                                  },
                                                  child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: (attributeIndex ==
                                                                      index)
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .transparent)),
                                                      // padding: EdgeInsets.all(4),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Center(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (colorKeys[
                                                                        index] ==
                                                                    'black')
                                                                ? Colors.black
                                                                : (colorKeys[
                                                                            index] ==
                                                                        'red')
                                                                    ? Colors.red
                                                                    : (colorKeys[index] ==
                                                                            'brown')
                                                                        ? Colors
                                                                            .brown
                                                                        : (colorKeys[index] ==
                                                                                'blue')
                                                                            ? Colors.blue
                                                                            : (colorKeys[index] == 'navy')
                                                                                ? Colors.blue.shade900
                                                                                : (colorKeys[index] == 'mustard')
                                                                                    ? Colors.yellow.shade800
                                                                                    : (colorKeys[index] == 'yellow')
                                                                                        ? Colors.yellow
                                                                                        : Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          height: 15,
                                                          width: 15,
                                                        ),
                                                      )),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // product name
                    Text(
                      productController.currentProduct!.value.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // product rating and review
                    Row(
                      spacing: 5,
                      children: [
                        SizedBox(
                          height: 10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              );
                            },
                          ),
                        ),
                        Text(
                          productController.currentProduct!.value.rating
                              .toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${productController.currentProduct!.value.reviews} Review(s)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // size row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    const Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // sizing information
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: productController
                                  .currentProduct!
                                  .value
                                  .attribute[productController
                                      .activeProductAttributeIndex.value]
                                  .size
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    productController.activeProductSizeIndex(
                                        productController
                                            .currentProduct!
                                            .value
                                            .attribute[productController
                                                .activeProductAttributeIndex
                                                .value]
                                            .size[index]);
                                    setState(() {
                                      sizeIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (sizeIndex == index)
                                          ? Colors.black
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: Text(
                                        productController
                                            .currentProduct!
                                            .value
                                            .attribute[productController
                                                .activeProductAttributeIndex
                                                .value]
                                            .size[index]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: (sizeIndex == index)
                                                ? Colors.white
                                                : Colors.grey),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // product description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      productController.currentProduct!.value.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),

                // product review
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Reviews (${productController.currentProduct!.value.reviews})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => const ProductReviewsScreen()),
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    uiUtils.reviewItem(),
                  ],
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: (widget.fromDashboard)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$${productController.currentProduct!.value.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.fromDashboard) {
                    uiUtils.addToCart(
                        product: productController.currentProduct!.value,
                        size: productController.activeProductSizeIndex.value,
                        attributeIndex: productController
                            .activeProductAttributeIndex.value);
                  } else {
                    uiUtils.reviewItemBottomSheet(
                        product: productController.currentProduct!.value);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 50,
                  width: 160,
                  child: Center(
                    child: Text(
                      (!widget.fromDashboard) ? 'REVIEW' : 'ADD TO CART',
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
