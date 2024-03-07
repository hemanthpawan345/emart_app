import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            customTextField(
              hint: 'address',
              isPass: false,
              title: 'Address',
              controller: controller.addressController,
            ),
            customTextField(
              hint: 'city',
              isPass: false,
              title: 'City',
              controller: controller.cityController,
            ),
            customTextField(
              hint: 'state',
              isPass: false,
              title: 'State',
              controller: controller.stateController,
            ),
            customTextField(
              hint: 'pincode',
              isPass: false,
              title: 'Pincode',
              controller: controller.postalcodeController,
            ),
            customTextField(
              hint: 'phone',
              isPass: false,
              title: 'Phone',
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Invalid address");
            }
          },
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
    );
  }
}
