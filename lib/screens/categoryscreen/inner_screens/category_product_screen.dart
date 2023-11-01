import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/screens/homescreen/widgets/product_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatefulWidget {
  static const routeName = '/categoryProduct';
  const CategoryProductScreen({super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  List<ProductModel> searchProductsList = [];
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> categoryProductList =
        productController.findProductByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: categoryProductList.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_products.json",
              emptyTitle: "No Products are available \nStay tuned")
          : FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //! search
                      TextFormField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        cursorColor:
                            GetColorThemeService(context).headingTextColor,
                        keyboardType: TextInputType.text,
                        onChanged: (seacrhValue) {
                          setState(() {
                            //* add searches
                            searchProductsList =
                                productController.searchProduct(seacrhValue);
                          });
                        },
                        style: AppTextStyle().mainTextStyle(
                            fSize: 15,
                            fWeight: FontWeight.w500,
                            color: GetColorThemeService(context).textColor),
                        maxLines: 1,
                        maxLength: 25,
                        decoration: InputDecoration(
                          hintText: "Search your product",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                                searchFocusNode.unfocus();
                              });
                            },
                            icon: Icon(Icons.cancel,
                                color: searchFocusNode.hasFocus
                                    ? redColor
                                    : Theme.of(context)
                                        .scaffoldBackgroundColor),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 3, 10, 3),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 0.8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 0.8),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! product card
                      searchProductsList.isEmpty &&
                              searchController.text.isNotEmpty
                          ? const EmptyWidget(
                              emptyAnimation:
                                  "assets/animations/empty_search.json",
                              emptyTitle:
                                  "No product found\nPlease try another keyword")
                          : GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: searchController.text.isNotEmpty
                                  ? searchProductsList.length
                                  : categoryProductList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 0.75),
                              itemBuilder: ((context, index) {
                                return ChangeNotifierProvider.value(
                                  value: searchController.text.isNotEmpty
                                      ? searchProductsList[index]
                                      : categoryProductList[index],
                                  child: const ProductCardWidegt(),
                                );
                              }),
                            ),
                      const VerticalSpacingWidget(height: 10)
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }
}
