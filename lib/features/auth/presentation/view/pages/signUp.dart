import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/routes/routes.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customButton.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customDivider.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customTextfield.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.KPrimaryBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Image.asset(
                  "assets/hero-area.png",
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.KSecoundaryBackgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome !",
                              style: TextStyle(
                                fontFamily: AppFonts.MainFont,
                                fontSize: 32,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Sign Up to new a account",
                              style: TextStyle(
                                fontFamily: AppFonts.MainFont,
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Customtextfield(
                        HintText: "Enter Your Full Name",
                        perfix: Icons.verified_user_rounded,
                        controller: name,
                        isPassword: false,
                      ),
                      SizedBox(height: 12),
                      Customtextfield(
                        HintText: "Enter Your Email",
                        perfix: Icons.email_outlined,
                        controller: email,
                        isPassword: false,
                      ),
                      SizedBox(height: 12),
                      Customtextfield(
                        HintText: "Enter Your Password",
                        perfix: Icons.password_outlined,
                        controller: password,
                        isPassword: true,
                      ),

                      SizedBox(height: 15),

                      Custombutton(
                        BtnText: "Sign up",
                        Icons: Icons.arrow_forward,
                        onPressd: () async {
                          try {
                            await AuthRepo().SignUp(
                              email: email.text.trim(),
                              name: name.text.trim(),
                              password: password.text.trim(),
                            );
                            Navigator.pushNamed(context, AppRouter.home);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        Background: AppColors.KMainBackgroundButtonColor,
                        foreBacground: Colors.white,
                      ),
                      Customdivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do You have an account ?"),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRouter.login);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
