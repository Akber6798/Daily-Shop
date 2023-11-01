import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/viewed_recently_controller.dart';
import 'package:daily_shop/screens/profileScreen/widgets/viewed_recently_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routeName = '/viewedRecently';
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedRecentlyController =
        Provider.of<ViewedRecentlyController>(context);
    final viewedRecentlyProductList = viewedRecentlyController
        .getViewedRecentlyProductItems.values
        .toList()
        .reversed
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Viewed Recently",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalServices.instance.closingDailogue(
                context,
                "Delete Viewed recently",
                "Do you want to delete?",
                () {
                  viewedRecentlyController.clearAllViewedRecntlyItems();
                },
              );
            },
            icon: Icon(IconlyLight.delete, color: redColor),
          )
        ],
      ),
      body: viewedRecentlyProductList.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_viewed.json",
              emptyTitle: "No products on your\n Viewed")
          : FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: ListView.builder(
                itemCount: viewedRecentlyProductList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ChangeNotifierProvider.value(
                      value: viewedRecentlyProductList[index],
                      child: const ViewedRecentlyCardWidget(),
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
