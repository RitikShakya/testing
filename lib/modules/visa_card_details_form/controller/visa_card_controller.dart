import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisaCardController extends GetxController{

  RxString cardNumber = "#### #### #### ####".obs;
  RxString holderName = 'FULL NAME'.obs;
  RxString expiryMonth = 'MM'.obs;
  RxString expiryYear = 'YY'.obs;
  RxString cvv = ''.obs;

  RxBool highlightNumber = false.obs;
  RxBool highlightName = false.obs;


  List<String> months = [
    '01','02','03','04','05','06','07','08','09','10','11','12'
  ];

  List<String> years = [];


  final TextEditingController cardNumberCtrl = TextEditingController();

  final TextEditingController holderNameCtrl = TextEditingController();

  final TextEditingController monthCtrl = TextEditingController();

  final TextEditingController yearCtrl = TextEditingController();

  final TextEditingController cvvCtrl = TextEditingController();
  final FocusNode cvvFocusNode = FocusNode();

  RxBool showBack = false.obs;


  @override
  void onInit() {

    final current = DateTime.now().year;
    for (int i = 0; i < 15; i++) {
      years.add((current + i).toString());
    }
    cvvFocusNode.addListener(() {
      showBack.value = cvvFocusNode.hasFocus;
    });
  }


  resetFields() {
    // Clear text controllers
    cardNumberCtrl.clear();
    holderNameCtrl.clear();
    monthCtrl.clear();
    yearCtrl.clear();
    cvvCtrl.clear();

    cardNumber.value = "#### #### #### ####";
    holderName.value = 'FULL NAME';
    expiryMonth.value = 'MM';
    expiryYear.value = 'YY';
    cvv.value = '';

    // Reset flip
    showBack.value = false;
  }

  void setCardNumber(String value) {
    value = value.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if ((i + 1) % 4 == 0 && i + 1 != value.length) buffer.write(' ');
    }
    cardNumber.value = buffer.toString();

    highlightNumber.value = value.isNotEmpty;
    highlightName.value = false;

  }


  void setCardHolder(String v) {
    holderName.value =
    v.isEmpty ? 'FULL NAME ' : v.toUpperCase();
    highlightName.value = v.isNotEmpty;
    highlightNumber.value = false;



  }

  String maskCardNumber(String value) {
    final digits = value.replaceAll(' ', '');

    if (digits.isEmpty) return '**** **** **** ****';

    // Helper to group into blocks of 4
    String groupInFours(String input) {
      final buffer = StringBuffer();
      for (int i = 0; i < input.length; i++) {
        buffer.write(input[i]);
        if ((i + 1) % 4 == 0 && i + 1 != input.length) {
          buffer.write(' ');
        }
      }
      return buffer.toString();
    }

    // If 4 or fewer digits, just show them (grouped)
    if (digits.length <= 4) {
      return groupInFours(digits);
    }

    String combined;

    if (digits.length <= 8) {
      // Keep first 4, mask the rest
      final first = digits.substring(0, 4);
      final restMasked =
      List.filled(digits.length - 4, '*').join(); // length always >= 1 here
      combined = '$first$restMasked';
    } else {
      // Keep first 4 and last 4, mask middle
      final first = digits.substring(0, 4);
      final last = digits.substring(digits.length - 4);
      final middleMasked =
      List.filled(digits.length - 8, '*').join(); // length >= 0
      combined = '$first$middleMasked$last';
    }

    return groupInFours(combined);
  }



}