import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
    debugPrint(username);
  }
}
