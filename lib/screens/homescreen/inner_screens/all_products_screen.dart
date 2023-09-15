import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/homeScreen/widgets/product_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                focusNode: searchFocusNode,
                cursorColor: GetColorThemeService(context).headingTextColor,
                keyboardType: TextInputType.text,
                onChanged: (newValue) {
                  setState(() {});
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
                      searchController.clear();
                      searchFocusNode.unfocus();
                    },
                    icon: Icon(Icons.cancel,
                        color: searchFocusNode.hasFocus
                            ? redColor
                            : Theme.of(context).scaffoldBackgroundColor),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: GetColorThemeService(context).headingTextColor,
                        width: 0.8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: GetColorThemeService(context).headingTextColor,
                        width: 0.8),
                  ),
                ),
              ),
              const VerticalSpacingWidget(height: 10),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.75),
                itemBuilder: ((context, index) {
                  return ProductCardWidegt();
                }),
              ),
              const VerticalSpacingWidget(height: 10)
            ],
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
