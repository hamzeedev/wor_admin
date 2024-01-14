import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/controllers/auth_controller.dart';
import 'package:wor_admin/views/home/home.dart';
import 'package:wor_admin/views/widgets/our_button.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 20.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 70,
                  )
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: appname, size: 20.0),
                      boldText(text: appType, size: 20.0, color: darkGrey),
                    ],
                  )
                ],
              ),
              40.heightBox,
              boldText(text: loginTo, size: 18.0, color: darkGrey),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    //TEXT Fields......
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    const Divider(),
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint,
                      ),
                    ),
                    //TEXT Fields......
                    const Divider(),
                    10.heightBox,
                    //FORGET PASSWORD...
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: normalText(
                            text: forgotPassword, color: purpleColor),
                      ),
                    ),
                    //LOGIN Button.....
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? loadingIndicator()
                          : ourButton(
                              title: login,
                              onPress: () async {
                                controller.isloading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(
                                      context, 
                                      msg: "Logged in",
                                      // bgColor: green,
                                      textSize: 18,
                                      );
                                    controller.isloading(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isloading(false);
                                  }
                                });
                              }),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              //LOGIN Button.....END
              18.heightBox,
              //ANY PROBLEM......
              Center(
                child: boldText(text: anyProblem, color: lightGrey),
              ),
              const Spacer(),
              //CREDIT.....
              Center(
                child: normalText(text: credit, color: lightGrey),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
