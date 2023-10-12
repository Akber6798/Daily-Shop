import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/order_controller.dart';
import 'package:daily_shop/screens/profileScreen/widgets/order_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);
    final orderList = orderController.getOrdersList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
           orderList.isEmpty ? "Order" : "Order (${orderList.length})",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        centerTitle: false,
      ),
      body: orderList.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_order.json",
              emptyTitle: "")
          : ListView.separated(
              itemCount: orderList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChangeNotifierProvider.value(
                    value: orderList[index],
                    child: const OrderCardWidget(),
                  ),
                );
              }),
              separatorBuilder: ((context, index) => Divider(
                  color: GetColorThemeService(context).headingTextColor)),
            ),
    );
  }
}
