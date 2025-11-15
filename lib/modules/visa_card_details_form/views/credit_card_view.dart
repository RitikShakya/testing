import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;
import '../controller/visa_card_controller.dart';

class CreditCardView extends StatelessWidget {
  final VisaCardController controller;

  const CreditCardView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  "assets/images/visa_card_background.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              // Slight dark overlay for readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.35),
                      ],
                    ),
                  ),
                ),
              ),
              // Content (front / back)
              Obx(
                    () {
                  if (controller.showBack.value) {

                    return Transform.rotate(
                      angle: math.pi, // 180 degrees
                      child: _buildBack(),
                    );
                  } else {
                    return _buildFront();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {

    final maskedNumber =controller.maskCardNumber(controller.cardNumber.value);

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top row: chip + VISA logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/chip.png",
                width: 40,
              ),
              Image.asset(
                "assets/images/visa.png",
                width: 60,
              ),
            ],
          ),
          const Spacer(),
          // card number with highlight container when editing number
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: Container(
              key: ValueKey(maskedNumber + controller.highlightNumber.value.toString()),
              padding: controller.highlightNumber.value
                  ? const EdgeInsets.symmetric(vertical: 6, horizontal: 10)
                  : EdgeInsets.zero,
              decoration: controller.highlightNumber.value
                  ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.5),
                color: Colors.white.withOpacity(0.08),
              )
                  : null,
              child: Text(
                maskedNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Card Holder',
                      style: TextStyle(
                        color: Color(0xFFBFD4FF),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      transitionBuilder: (child, anim) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(anim),
                        child: FadeTransition(
                          opacity: anim,
                          child: child,
                        ),
                      ),
                      child: Container(
                        key: ValueKey(
                            controller.holderName.value + controller.highlightName.value.toString()),
                        padding: controller.highlightName.value
                            ? const EdgeInsets.symmetric(vertical: 4, horizontal: 8)
                            : EdgeInsets.zero,
                        decoration: controller.highlightName.value
                            ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 1.2),
                          color: Colors.white.withOpacity(0.08),
                        )
                            : null,
                        child: Text(
                          controller.holderName.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expires',
                    style: TextStyle(
                      color: Color(0xFFBFD4FF),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: Text(
                      '${controller.expiryMonth.value}/${controller.expiryYear.value}',
                      key: ValueKey(
                          '${controller.expiryMonth.value}/${controller.expiryYear.value}'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // magnetic stripe
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            color: Colors.black.withOpacity(0.8),
          ),
          const SizedBox(height: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'CVV',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Obx(
                      () => Text(
                    controller.cvv.value.isEmpty
                        ? '***'
                        : '*' * controller.cvv.value.length,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/visa.png",
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}