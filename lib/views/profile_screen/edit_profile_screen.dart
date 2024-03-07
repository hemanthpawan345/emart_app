import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../../widgets_common/bg_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: 'Change',
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                hint: nameHint,
                isPass: false,
                title: name,
                controller: controller.nameController,
              ),
              10.heightBox,
              customTextField(
                hint: passwordHint,
                isPass: true,
                title: oldPassword,
                controller: controller.oldPasswordController,
              ),
              10.heightBox,
              customTextField(
                hint: passwordHint,
                isPass: true,
                title: newPassword,
                controller: controller.newPasswordController,
              ),
              20.heightBox,
              controller.isLoading.value == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.width - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);
                          //if image is not selected
                          if (controller.profileImagePath.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          if (data['password'] ==
                              controller.oldPasswordController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: data['password'],
                              newPassword:
                                  controller.newPasswordController.text,
                            );
                            await controller.updateProfile(
                              imageUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newPasswordController.text,
                            );
                            VxToast.show(context, msg: 'Updated');
                          } else {
                            VxToast.show(context, msg: 'Wrong old password');
                            controller.isLoading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: 'Save',
                      ),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, right: 12, left: 12))
              .make(),
        ),
      ),
    );
  }
}
