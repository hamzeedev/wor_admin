import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wor_admin/const/colors.dart';
import 'package:wor_admin/const/images.dart';
import 'package:wor_admin/const/strings.dart';
import 'package:wor_admin/controllers/home_controller.dart';
import 'package:wor_admin/views/home/home_screen.dart';
import 'package:wor_admin/views/booking_screen/booking_screen.dart';
import 'package:wor_admin/views/wheels_screen/wheels_screen.dart';
import 'package:wor_admin/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const WheelsScreen(),
      const BookingsScreen(),
      const ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkGrey,
          ),
          label: products),
      BottomNavigationBarItem(
        icon: Image.asset(
          icOrders,
          width: 24,
          color: darkGrey,
        ),
        label: orders,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            width: 24,
            color: darkGrey,
          ),
          label: settings),
    ];
    return Scaffold(

      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      body: Column(
        children: [
          Obx(()=> Expanded(child: navScreens.elementAt(controller.navIndex.value))),
        ],
      ),
    );
  }
}
