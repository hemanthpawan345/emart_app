import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog({context}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        "Confirm".text.size(18).color(darkFontGrey).fontFamily(bold).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you wanna exit".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ourButton(
              color: redColor,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: 'Yes',
            ),
            ourButton(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: 'no',
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
