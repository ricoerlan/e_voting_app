import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Variable to track the current selected tab
  int selectedIndex = 0;

  // Function to change tab and update the state
  void changeTabIndex(int index) {
    selectedIndex = index;
    update(); // Call update to rebuild the widget
  }
}
