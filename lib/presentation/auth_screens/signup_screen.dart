// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/main.dart';
import 'package:time_tracker/models/share_pref_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/presentation/auth_screens/login_screen.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/navigation_helper.dart';
import 'package:time_tracker/presentation/user_side/app_side_bar.dart';
import 'package:time_tracker/services/auth_service.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/app_checkbox.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/global_timetracking_text_with_icon_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  double mediaWidth = 0.0;
  bool termsConditions = false;
  bool captcha = false;
  String firstNameErrorTxt = '';
  String lastNameErrorTxt = '';
  String emailErrorTxt = '';
  String organizationNameErrorTxt = '';
  String passwordErrorTxt = '';
  String reEnterPasswordErrorTxt = '';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  AuthService authService = AuthService();
  DatabaseServices databaseServices = DatabaseServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();
  bool accountCreating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Center(
                child: GlobalTimeTrackingTextWithIcon(
              mainAxisAlignment: MainAxisAlignment.center,
            )),
            const SizedBox(height: 30),
            const Text(
              'Sign up form',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaWidth > 900 ? mediaWidth / 3.8 : 80),
              child: const Text(
                'Track your time, unlock powerful insights, and generate informative reports with our user-friendly time tracking services.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              'First Name*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            filled: true,
                            hintText: 'Enter First Name',
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            errorText: firstNameErrorTxt,
                            textController: firstNameController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'First Name Required';
                              }
                              return null;
                            },
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 10),
                            child: Text(
                              'Email Address*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            filled: true,
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            hintText: 'Enter Email',
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
                                EdgeInsets.only(top: 10, left: 20, bottom: 10),
                            child: Text(
                              'Password*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            filled: true,
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            hintText: 'Enter Password',
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
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
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              'Last Name*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            filled: true,
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            hintText: 'Enter Last Name',
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            errorText: lastNameErrorTxt,
                            textController: lastNameController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Last Name Required';
                              }
                              return null;
                            },
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 10),
                            child: Text(
                              'Organization User Name*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            filled: true,
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            hintText: 'Enter Organization User Name',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorText: organizationNameErrorTxt,
                            textController: organizationNameController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Organization Name Required';
                              }
                              return null;
                            },
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 10),
                            child: Text(
                              'Re-enter Password*',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          RoundedTextField(
                            filled: true,
                            textFieldColor:
                                AppColors.appDarkGrey.withOpacity(0.09),
                            borderColor: Colors.transparent,
                            hintText: 'Re Enter Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            errorText: reEnterPasswordErrorTxt,
                            textController: reEnterPasswordController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Re-enter Password';
                              } else if (passwordController.text !=
                                  reEnterPasswordController.text) {
                                return 'Password not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10) +
                  const EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  AppCheckbox(
                    checkbox: termsConditions,
                    onValueChanged: (value) {
                      termsConditions = value!;
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'By clicking you are agree to our',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  GlobalTextButton(
                    text: 'Terms & Conditions',
                    borderColor: Colors.transparent,
                    buttonTextColor: AppColors.appPrimaryColor,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.appPrimaryColor),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 280,
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppCheckbox(
                        borderSide: const BorderSide(
                            color: AppColors.appDarkGrey, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        checkbox: captcha,
                        onValueChanged: (value) {
                          captcha = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'I\'m not a robot',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SvgPicture.asset(IconImages.recaptha)
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30) +
                    const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appPrimaryColor,
                      fixedSize: const Size(500, 50)),
                  onPressed: accountCreating
                      ? null
                      : () async {
                          createAccount();
                        },
                  child: accountCreating
                      ? const WaveLoadingWidget(
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Opacity(
                              opacity: 0,
                              child: Icon(Icons.arrow_forward),
                            ),
                            const Text(
                              'Get Registered',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 30),
                            SvgPicture.asset(
                              IconImages.next,
                              color: Colors.white,
                            ),
                          ],
                        ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GlobalTextButton(
                  text: AppTexts.login,
                  borderColor: Colors.transparent,
                  buttonTextColor: AppColors.appPrimaryColor,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.appPrimaryColor),
                  onTap: () {
                    gotoNextPageRemoveUntill(context, const LoginScreen());
                  },
                ),
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  createAccount() async {
    if (formKey.currentState!.validate()) {
      if (termsConditions == false || captcha == false) {
        context.showInfoSnackBar('Please check privacy policy or captha!');
      } else {
        try {
          setState(() {
            accountCreating = true;
          });
          var data = await authService.signUpWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim());
          if (data.user != null) {
            setState(() {
              accountCreating = false;
            });
            var userData =
                await databaseServices.findUser(emailController.text.trim());
            if (userData.exists) {
              UserModel userPrevData =
                  UserModel.fromJson(userData.data() as Map<String, dynamic>);
              log('email exist');
              databaseServices.updateUser(
                UserModel(
                  email: userPrevData.email,
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  organizationUserName: organizationNameController.text.trim(),
                  profile: userPrevData.profile,
                  role: userPrevData.role,
                ),
              );
            } else {
              databaseServices.addUserToFirestore(
                UserModel(
                  email: emailController.text.trim(),
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  organizationUserName: organizationNameController.text.trim(),
                  role: 'user',
                ),
              );
            }

            context.showSuccessSnackBar(
              'Account created!',
            );

            await sharedPrefServices.saveUserDataLoacally(
              SharePrefModel(
                email: emailController.text.trim(),
                loginMethod: 'email',
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                role: 'user',
              ),
            );
            gotoNextPageRemoveUntill(
              context,
              const FirstPage(),
            );
          }
          debugPrint('SignUp succesfull and here is data ------$data');
        } on FirebaseAuthException catch (e) {
          setState(() {
            accountCreating = false;
          });
          switch (e.code) {
            case ('account-exists-with-different-credential' ||
                  'email-already-in-use'):
              return context.showErrorSnackBar(
                "Account already exists with a different credentials.",
              );
            case ('invalid-credential'):
              return context.showErrorSnackBar(
                "Account already exists with a different credentials.",
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
}
