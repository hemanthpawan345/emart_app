import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:get/get.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Choose Payment Method'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => Column(
            children: List.generate(
              paymentMethodsList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsList[index],
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            controller.placeMyOrder(
              orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
              totalAmount: controller.totalP.value,
            );
            // controller.getProductDetails();
          },
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
    );
  }
}
