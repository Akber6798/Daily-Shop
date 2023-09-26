import 'package:daily_shop/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadinWidget extends StatelessWidget {
  const LoadinWidget({super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
                color: Colors.black.withOpacity(0.7),
              )
            : Container(),
        isLoading
            ? Center(
                child: SpinKitFadingCircle(
                  color: whiteColor,
                  size: 50.0,
                ),
              )
            : Container()
      ],
    );
  }
}
