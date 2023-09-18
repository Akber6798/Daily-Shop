import 'package:card_swiper/card_swiper.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_data_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165.h,
      child: Swiper(
        autoplay: true,
        itemCount: offerImages.length,
        itemBuilder: ((context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              offerImages[index],
              fit: BoxFit.fill,
            ),
          );
        }),
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              color: Colors.grey, activeColor: redColor),
        ),
      ),
    );
  }
}
