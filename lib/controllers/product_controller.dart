import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.0.obs;
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  void increQuantity(data) {
    if (quantity.value < int.parse(data)) {
      quantity.value += 1;
    }
  }

  void decreQuantity() {
    if (quantity.value > 0) {
      quantity.value -= 1;
    }
  }

  addToCart({title, img, sellername, color, qty, totalprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'totalprice': totalprice,
      'added_by': currentUser!.uid,
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishlist(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");

  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  void checkIsFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
