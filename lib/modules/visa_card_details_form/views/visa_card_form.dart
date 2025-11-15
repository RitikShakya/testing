import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/common_widgets/custom_text_field.dart';

import 'dart:math' as math;
import 'package:testing/modules/visa_card_details_form/controller/visa_card_controller.dart';
import 'package:testing/utils/text_utils.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../utils/color_utils.dart';
import 'credit_card_view.dart';

class VisaCardForm extends StatelessWidget {

  // for any functions to run
  VisaCardController controller =Get.find();

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Card view with animation
                  Obx(
                        () => AnimatedRotation(

                      turns: controller.showBack.value ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: CreditCardView(controller: controller),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Card Number',
                          controller: controller.cardNumberCtrl,
                          keyBoardtype: TextInputType.number,
                          onChanged: controller.setCardNumber,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Card Holder',
                          controller: controller.holderNameCtrl,
                          onChanged:controller.setCardHolder

                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Expiration Date",
                              style: TextUtils.textLabelheadings,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(

                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(

                                value: controller.expiryMonth.value == 'MM'
                                    ? null
                                    : controller.expiryMonth.value,
                                decoration: InputDecoration(
                                  labelText: "Expiry Month",
                                  hintText: "MM",
                                  filled: true,
                                  fillColor: ColorUtils.WHITE_COLOR_BACKGROUND,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: ColorUtils.GREY_DOTTED,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                items: controller.months
                                    .map(
                                      (m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m),
                                  ),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  controller.expiryMonth.value = value!;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: controller.expiryYear.value == 'YY'
                                    ? null
                                    : controller.expiryYear.value,
                                decoration: InputDecoration(
                                  labelText: "Expiry Year",
                                  hintText: "YY",
                                  filled: true,
                                  fillColor: ColorUtils.WHITE_COLOR_BACKGROUND,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: ColorUtils.GREY_DOTTED,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                items: controller.years
                                    .map(
                                      (y) => DropdownMenuItem(
                                    value: y,
                                    child: Text(y),
                                  ),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  controller.expiryYear.value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),


                        Container(
                          width: width,
                          child: CustomTextField(
                            label: 'CVV',
                            controller: controller.cvvCtrl,
                            focusNode: controller.cvvFocusNode,
                            keyBoardtype: TextInputType.number,
                            obscureText: true,
                            onChanged: (v) => controller.cvv.value = v,
                          ),
                        ),

                        const SizedBox(height: 24),
                        CustomButton(
                          onTap: (){
                            controller.resetFields();
                          },
                          buttonText: "Reset",

                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- CARD VIEW --------------------

