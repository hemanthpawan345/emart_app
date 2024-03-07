import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controllers/chat_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/components/seller_bubble.dart';
import 'package:emart_app/views/chat_screen/components/sender_bubble.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Obx(
              () => controller.isLoading.value
                  ? Center(child: loadingIndicator())
                  : Expanded(
                      child: StreamBuilder(
                        stream: FireStoreServices.getChatMessages(
                          controller.chatDocId.toString(),
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Send a message.."
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return data['uid'] == currentUser!.uid
                                    ? senderBubble(data)
                                    : sellerBubble(data);
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: redColor)),
              ],
            )
                .box
                .margin(const EdgeInsets.only(bottom: 8))
                .height(80)
                .padding(const EdgeInsets.all(12))
                .make()
          ],
        ),
      ),
    );
  }
}
