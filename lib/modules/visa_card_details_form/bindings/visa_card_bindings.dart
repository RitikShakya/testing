import 'package:get/get.dart';
import 'package:testing/modules/visa_card_details_form/controller/visa_card_controller.dart';

class VisaCardBindings extends Bindings{

  @override
  void dependencies() {


    Get.put(VisaCardController());
    // TODO: implement dependencies
  }
}