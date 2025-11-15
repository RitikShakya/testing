import 'package:get/get.dart';

import '../controller/homepage_controller.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {

    Get.put(HomepageController());
    // TODO: implement dependencies
  }


}