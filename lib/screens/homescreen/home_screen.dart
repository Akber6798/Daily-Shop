import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/offer_all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/widgets/ad_banner_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/heading_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/offer_product_card_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/product_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductController>(context, listen: false);
    productProvider.fetchProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    List<ProductModel> allProducts = productController.getProductList;
    List<ProductModel> offerAllProducts = productController.getOfferProductList;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacingWidget(height: 30.h),
              //! heading section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DAILY SHOP",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 20,
                        fWeight: FontWeight.w600,
                        color: GetColorThemeService(context).headingTextColor),
                  ),
                  Image(
                    height: 30.h,
                    width: 30.w,
                    image: const AssetImage("assets/icons/logo.png"),
                  )
                ],
              ),
              const VerticalSpacingWidget(height: 20),
              //! ad banner
              const AdBannerWidget(),
              const VerticalSpacingWidget(height: 10),
              //! offer widget
              HeadingWidget(
                  title: "Today Offers",
                  viewAllFunction: () {
                    GlobalServices.instance.navigateTo(
                        context: context,
                        routeName: OfferAllProductsScreen.routeName);
                  }),

              SizedBox(
                height: 178.h,
                child: ListView.builder(
                    itemCount: offerAllProducts.length < 7
                        ? offerAllProducts.length
                        : 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                        child: ChangeNotifierProvider.value(
                          value: offerAllProducts[index],
                          child: const OfferProductCardWidget(),
                        ),
                      );
                    }),
              ),
              //! product widget
              HeadingWidget(
                  title: "All Products",
                  viewAllFunction: () {
                    GlobalServices.instance.navigateTo(
                        context: context,
                        routeName: AllProductsScreen.routeName);
                  }),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allProducts.length < 4 ? allProducts.length : 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    childAspectRatio: 0.75),
                itemBuilder: ((context, index) {
                  return ChangeNotifierProvider.value(
                    value: allProducts[index],
                    child: const ProductCardWidegt(),
                  );
                }),
              ),
              const VerticalSpacingWidget(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
