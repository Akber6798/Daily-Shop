// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/commonwidgets/loading_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editPhoneNumberController =
      TextEditingController();
  final TextEditingController editHouseNameController = TextEditingController();
  final TextEditingController editStreetNameConroller = TextEditingController();
  final TextEditingController editPincodeController = TextEditingController();
  final User? user = authenticationInstance.currentUser;
  bool isLoading = false;
  bool isCircleLoading = false;

  //* get user details from database
  Future<void> getUserInformation() async {
    setState(() {
      isLoading = true;
    });
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      String userId = user!.uid;
      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection("userDetails")
          .doc(userId)
          .get();
      if (userData == null) {
        return;
      } else {
        editNameController.text = userData.get('name');
        editPhoneNumberController.text = userData.get('phoneNumber');
        editHouseNameController.text = userData.get('houseName');
        editStreetNameConroller.text = userData.get('streetName');
        editPincodeController.text = userData.get('pincode');
      }
    } catch (error) {
      GlobalServices.instance.errorDailogue(
        context,
        error.toString(),
      );
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //* update
  Future<void> updateUserDetails() async {
    setState(() {
      isCircleLoading = true;
    });
    String userId = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('userDetails')
          .doc(userId)
          .update({
        'name': editNameController.text,
        'phoneNumber': editPhoneNumberController.text,
        'houseName': editHouseNameController.text,
        'streetName': editStreetNameConroller.text,
        'pincode': editPincodeController.text
      });
      Fluttertoast.showToast(
          msg: "Updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: whiteColor,
          fontSize: 16.sp);
      setState(() {
        isCircleLoading = false;
      });
    } catch (error) {
      GlobalServices.instance.errorDailogue(
        context,
        error.toString(),
      );
      setState(() {
        isCircleLoading = false;
      });
    } finally {
      setState(() {
        isCircleLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return LoadinWidget(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                VerticalSpacingWidget(height: 30),
                //! edit name
                TextFormField(
                  controller: editNameController,
                  keyboardType: TextInputType.name,
                  cursorColor: GetColorThemeService(context).headingTextColor,
                  style: AppTextStyle().mainTextStyle(
                      fSize: 15,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                  ),
                ),
                VerticalSpacingWidget(height: 10),
                //!  edit phone number
                TextFormField(
                  controller: editPhoneNumberController,
                  keyboardType: TextInputType.number,
                  cursorColor: GetColorThemeService(context).headingTextColor,
                  style: AppTextStyle().mainTextStyle(
                      fSize: 15,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                  ),
                ),
                VerticalSpacingWidget(height: 10),
                //! edit house name
                TextFormField(
                  controller: editHouseNameController,
                  keyboardType: TextInputType.text,
                  cursorColor: GetColorThemeService(context).headingTextColor,
                  style: AppTextStyle().mainTextStyle(
                      fSize: 15,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                  ),
                ),
                VerticalSpacingWidget(height: 10),
                //! edit street name
                TextFormField(
                  controller: editStreetNameConroller,
                  keyboardType: TextInputType.text,
                  cursorColor: GetColorThemeService(context).headingTextColor,
                  style: AppTextStyle().mainTextStyle(
                      fSize: 15,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                  ),
                ),
                VerticalSpacingWidget(height: 10),
                //! edit pin code
                TextFormField(
                  controller: editPincodeController,
                  keyboardType: TextInputType.number,
                  cursorColor: GetColorThemeService(context).headingTextColor,
                  style: AppTextStyle().mainTextStyle(
                      fSize: 15,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: GetColorThemeService(context).headingTextColor,
                          width: 1),
                    ),
                  ),
                ),
                VerticalSpacingWidget(height: 50),
                //! reset
                InkWell(
                  onTap: () async {
                    await updateUserDetails();
                    ;
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: GetColorThemeService(context).headingTextColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isCircleLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            )
                          : Text(
                              "Reset",
                              style: AppTextStyle.instance.mainTextStyle(
                                  fSize: 18.sp,
                                  fWeight: FontWeight.w500,
                                  color: whiteColor),
                            ),
                    ),
                  ),
                )
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
    editNameController.dispose();
    editPhoneNumberController.dispose();
    editHouseNameController.dispose();
    editStreetNameConroller.dispose();
    editPincodeController.dispose();
  }
}
