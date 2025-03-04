import 'package:get/get.dart';

class BottomBarController extends GetxController{

  //RxInt currentIndex = 0.obs;

  var currentIndex = 0.obs;
  var selectedIndex = 0.obs;
  void changeTabIndex(int index) {
    currentIndex.value = index;
    // _selectedIndex.value = index;
  }
}