import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/models/order_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget({super.key});

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orderModel = Provider.of<OrderModel>(context);
    var orderDate = orderModel.orderDate.toDate();
    orderDateToShow = "${orderDate.day}/${orderDate.month}/${orderDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context);
    final productController = Provider.of<ProductController>(context);
    final currentProduct =
        productController.findProductById(orderModel.productId);
    return ListTile(
      onTap: () {
        GlobalServices.instance.navigateTo(
            context: context, routeName: ProductDetailScreen.routeName);
      },
      title: Text(
        "${currentProduct.title} X ${orderModel.quantity}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.instance.mainTextStyle(
            fSize: 14.sp,
            fWeight: FontWeight.w500,
            color: GetColorThemeService(context).headingTextColor),
      ),
      subtitle: Text(
        "Paid ₹ ${double.parse(orderModel.price).toStringAsFixed(2)}",
        style: AppTextStyle.instance.mainTextStyle(
            fSize: 12.sp,
            fWeight: FontWeight.w400,
            color: GetColorThemeService(context).textColor),
      ),
      trailing: Text(orderDateToShow),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: FancyShimmerImage(
          imageUrl: currentProduct.imageUrl,
          height: 50.h,
          width: 85.w,
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }
}
