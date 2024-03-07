import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.title, this.data});
  final dynamic data;
  final String title;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        controller.resetValues();
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: title.text.color(darkFontGrey).fontFamily(bold).make(),
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      10.heightBox,
                      title.text
                          .size(16)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                '${data['p_seller']}'
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ).box.height(60).make(),
                          ).onTap(() {
                            Get.to(
                              () => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']],
                            );
                          }),
                        ],
                      )
                          .box
                          .height(70)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      //color section
                      10.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Colors: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .border(width: 0.5)
                                            .roundedFull
                                            .margin(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4),
                                            )
                                            .color(
                                                Color(data['p_colors'][index])
                                                    .withOpacity(1.0))
                                            .make()
                                            .onTap(
                                          () {
                                            controller.changeColorIndex(index);
                                          },
                                        ),
                                        Visibility(
                                          visible: index ==
                                              controller.colorIndex.value,
                                          child: const Icon(Icons.done),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreQuantity();
                                          controller.calculateTotalPrice(
                                            double.parse(data['p_price']),
                                          );
                                        },
                                        icon: const Icon(Icons.remove)),
                                    "${controller.quantity.value}"
                                        .text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increQuantity(
                                            data['p_quantity'],
                                          );
                                          controller.calculateTotalPrice(
                                            double.parse(data['p_price']),
                                          );
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.heightBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //total
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      //description
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      //more details
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailButtonsList.length,
                          (index) => ListTile(
                            title: itemDetailButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      20.heightBox,
                      //products you may like

                      productsyoumaylike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1,
                                    width: 150, fit: BoxFit.cover),
                                10.heightBox,
                                "Laptop 4GB/64GB"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "\$600"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                                10.heightBox,
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(8))
                                .make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {
                  controller.addToCart(
                    color: data['p_colors'][controller.colorIndex.value],
                    context: context,
                    img: data['p_imgs'][0],
                    sellername: data['p_seller'],
                    qty: controller.quantity.value,
                    totalprice: controller.totalPrice.value,
                    title: data['p_name'],
                  );
                  VxToast.show(context, msg: 'Added to cart');
                },
                textColor: whiteColor,
                title: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
