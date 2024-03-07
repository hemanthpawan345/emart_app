import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200,
            ),
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Image.asset(categoryImages[index],
                      height: 120, width: 200, fit: BoxFit.cover),
                  10.heightBox,
                  categoryList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .rounded
                  .white
                  .clip(Clip.antiAlias)
                  .outerShadow
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoryList[index]);
                Get.to(() => CategoryDetails(title: categoryList[index]));
              });
            },
          ),
        ),
      ),
    );
  }
}
