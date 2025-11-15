import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/modules/homepage_screen/controller/homepage_controller.dart';
import 'package:testing/utils/routes/routing_names.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';

class Homepage extends StatelessWidget {

  HomepageController controller =Get.find();

  @override
  Widget build(BuildContext context) {


    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFE7F0FF),

        appBar: AppBar(
        elevation: 2,
        title: Text("Test"),


      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [



            Text("Welcome to the Project , Hope you are doing well !!",style: TextUtils.heading1,textAlign: TextAlign.center,),

             SizedBox(height: 48,),
            CustomButton(
              onTap: (){
                Get.toNamed(RoutingNames.VISA_CARD_FORM);

              },
              buttonText: "Check the Credit Card Form",

            ),
             // you can use a custom button as well from the custom widgets which you used

          ],
        ),
      )
    );
  }
}
