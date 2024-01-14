import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';

class AuthController extends GetxController{

    var isloading = false.obs;

  //textControllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  //login method....
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
   //signout methods....
  signoutMethod (context) async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

}