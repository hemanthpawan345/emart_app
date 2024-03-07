import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  //controllers

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Authcontroller());
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.height * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log into $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController,
                    ),
                    customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: controller.passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: redColor,
                            textColor: whiteColor,
                            title: login,
                            onPress: () async {
                              controller.isLoading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  controller.passwordController.text = '';
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            },
                          ).box.width(context.width - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                      color: lightGolden,
                      textColor: redColor,
                      title: signup,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      },
                    ).box.width(context.width - 50).make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .shadowMax
                    .padding(const EdgeInsets.all(16))
                    .width(context.width - 70)
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
