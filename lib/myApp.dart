import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/modules/visa_card_details_form/bindings/visa_card_bindings.dart';
import 'package:testing/modules/visa_card_details_form/views/visa_card_form.dart';
import 'package:testing/utils/routes/routing_names.dart';

import 'modules/homepage_screen/bindings/homepage_binding.dart';
import 'modules/homepage_screen/views/homepage.dart';


//using getx for state managment

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          textTheme: TextTheme(
            bodyMedium: TextStyle(
                color: Colors.red
            ),
            bodyLarge: TextStyle(
                color: Colors.black
            ),
          )
      ),

      unknownRoute: GetPage(name: RoutingNames.HOME_PAGE_ROUTE, page:()=> Homepage(),binding: HomePageBinding()),


      // initialRoute: "/",
      getPages: [
        GetPage(name:RoutingNames.HOME_PAGE_ROUTE, page:()=> Homepage(),binding: HomePageBinding()),
        GetPage(name:RoutingNames.VISA_CARD_FORM, page:()=> VisaCardForm(),binding: VisaCardBindings())

      ],
    );
  }
}
