// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/helpers/navigation_helper.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/main.dart';
import 'package:time_tracker/models/share_pref_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/dashboard_main_screen.dart';
import 'package:time_tracker/presentation/auth_screens/signup_screen.dart';
import 'package:time_tracker/presentation/user_side/app_side_bar.dart';
import 'package:time_tracker/services/auth_service.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/global_timetracking_text_with_icon_widget.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';
import 'package:time_tracker/widgets/global_flat_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool googleSignIn = false;
  final formKey = GlobalKey<FormState>();
  double mediaWidth = 0.0;
  String emailErrorTxt = '';
  String passwordErrorTxt = '';
  bool loginWithEmail = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  DatabaseServices databaseServices = DatabaseServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  @override
  Widget build(BuildContext context) {
    mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(
                50,
              ),
              bottomRight: Radius.circular(
                50,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              height: double.infinity,
              width: mediaWidth / 2,
              child: Image.asset(
                AppImages.loginImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: mediaWidth / 2,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      right: 20,
                    ),
                    child: GlobalTimeTrackingTextWithIcon(
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                      AppTexts.login,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            AppTexts.email,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                        RoundedTextField(
                          filled: true,
                          hintText: 'james@gmail.com',
                          textFieldColor:
                              AppColors.appDarkGrey.withOpacity(0.09),
                          borderColor: Colors.transparent,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          errorText: emailErrorTxt,
                          textController: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address.';
                            }
                            if (!isValidEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 30, left: 20, bottom: 10),
                          child: Text(
                            AppTexts.password,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                        RoundedTextField(
                          filled: true,
                          hintText: '********',
                          textFieldColor:
                              AppColors.appDarkGrey.withOpacity(0.09),
                          borderColor: Colors.transparent,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          errorText: passwordErrorTxt,
                          textController: passwordController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Password Required';
                            } else if (p0.length < 8) {
                              return 'Password must be 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: GlobalFlatButton(
                            isLoading: loginWithEmail,
                            text: AppTexts.login,
                            textColor: Colors.white,
                            onTap: () async => loginUserWithEmailPassword(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            AppTexts.enjoyLoginWith,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.appDarkGrey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: IconButtonWithLabel(
                                  borderColor:
                                      AppColors.appDarkGrey.withOpacity(
                                    0.1,
                                  ),
                                  isLoading: googleSignIn,
                                  iconRightSpacing: 5,
                                  textColor: Colors.black,
                                  icon: IconImages.google,
                                  text: AppTexts.google,
                                  onTap: () async {
                                    try {
                                      setState(() {
                                        googleSignIn = true;
                                      });
                                      GoogleSignInAccount? account =
                                          await authService.signInWithGoogle();
                                      if (account != null) {
                                        debugPrint(account.toString());
                                        // await authService
                                        //     .userSignOutfromGoogle();
                                        UserModel? userData;
                                        var data = await databaseServices
                                            .findUser(account.email);

                                        if (data.exists) {
                                          userData = UserModel.fromJson(data
                                              .data() as Map<String, dynamic>);
                                          databaseServices.updateUser(
                                            UserModel(
                                              email: account.email,
                                              profile:
                                                  userData.profile?.isEmpty ??
                                                          true
                                                      ? account.photoUrl
                                                      : userData.profile,
                                              firstName: userData.firstName,
                                              lastName: userData.lastName,
                                              organizationUserName:
                                                  userData.organizationUserName,
                                              role: userData.role,
                                              teams: userData.teams,
                                            ),
                                          );
                                          await sharedPrefServices
                                              .saveUserDataLoacally(
                                            SharePrefModel(
                                                email: account.email,
                                                loginMethod: 'google',
                                                role: userData.role,
                                                profile: account.photoUrl),
                                          );
                                        } else {
                                          databaseServices.addUserToFirestore(
                                            UserModel(
                                              email: account.email,
                                              profile: account.photoUrl,
                                              role: 'user',
                                            ),
                                          );
                                          await sharedPrefServices
                                              .saveUserDataLoacally(
                                            SharePrefModel(
                                              email: account.email,
                                              loginMethod: 'google',
                                              role: 'user',
                                              profile: account.photoUrl,
                                            ),
                                          );
                                        }

                                        gotoNextPageRemoveUntill(
                                            context, const FirstPage());
                                      }
                                    } catch (e) {
                                      debugPrint(
                                          'here is error ------------$e');
                                      if (e
                                          .toString()
                                          .contains('TimeoutException')) {
                                        context.showErrorSnackBar(
                                          'Request timed out',
                                        );
                                      }
                                      setState(() {
                                        googleSignIn = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GlobalTextButton(
                            text: AppTexts.getRegisterHere,
                            borderColor: Colors.transparent,
                            buttonTextColor: AppColors.appPrimaryColor,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.appPrimaryColor,
                            ),
                            onTap: () async {
                              gotoNextPageRemoveUntill(
                                context,
                                const SignUpScreen(),
                              );

                              // //calling for encryption and decryption
                              // final secretKey = "your_secret_key";
                              // final jsonData = {"name": "John", "age": 30};

                              // // Encrypting JSON data
                              // final encryptedData = SimpleEncryption.encrypt(
                              //     jsonEncode(jsonData), secretKey);
                              // print('Encrypted Data: $encryptedData');

                              // // Decrypting the encrypted data
                              // final decryptedData = SimpleEncryption.decrypt(
                              //     encryptedData, secretKey);
                              // print('Decrypted Data: $decryptedData');

                              // var data = await databaseServices
                              //     .findSingleUser('jo@doe.com');
                              // List<UserModel> users = [];
                              // for (int i = 0; i < data.length; i++) {
                              //   users.add(UserModel.fromJson(data[i]));
                              // }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  loginUserWithEmailPassword() async {
    if (formKey.currentState!.validate()) {
      print('login with email password');
      try {
        setState(() {
          loginWithEmail = true;
        });

        var data = await authService.signInWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (data.user != null) {
          setState(() {
            loginWithEmail = false;
          });

          var dat = await databaseServices.findUser(data.user?.email ?? '');

          UserModel userData =
              UserModel.fromJson(dat.data() as Map<String, dynamic>);

          await sharedPrefServices.saveUserDataLoacally(
            SharePrefModel(
              email: emailController.text.trim(),
              loginMethod: 'email',
              role: userData.role == 'user' ? 'user' : 'admin',
            ),
          );
          context.showSuccessSnackBar(
            'Login successful!',
          );
          await Future.delayed(const Duration(milliseconds: 5));
          {
            gotoNextPageRemoveUntill(
              context,
              const FirstPage(),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loginWithEmail = false;
        });
        switch (e.code) {
          case ('account-exists-with-different-credential' ||
                'email-already-in-use'):
            return context.showErrorSnackBar(
              "Account already exists with a different credentials.",
            );
          case ('auth/invalid-credential'):
            return context.showErrorSnackBar(
              "Invalid credentials.",
            );
          case ('unknown-error'):
            return context.showErrorSnackBar(
              "Check your credentials.",
            );
          default:
            context.showErrorSnackBar(
              '${e.code}. Try again.',
            );
        }
      }
    }
  }
}
