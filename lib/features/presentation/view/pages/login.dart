import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/features/presentation/view/widgets/customButton.dart';
import 'package:lumiere/features/presentation/view/widgets/customDivider.dart';
import 'package:lumiere/features/presentation/view/widgets/customTextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Welcome back !",
                            style: TextStyle(
                              fontFamily: AppFonts.MainFont,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Sign in to your account",
                            style: TextStyle(
                              fontFamily: AppFonts.MainFont,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
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
                      controller: Password,
                      isPassword: true,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Forgot password ?",
                            style: TextStyle(
                              fontFamily: AppFonts.MainFont,
                              color: Color(0xffC9A962),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Custombutton(
                      BtnText: "Sign in",
                      Icons: Icons.arrow_forward,
                      onPressd: () {},
                      Background: AppColors.KMainBackgroundButtonColor,
                      foreBacground: Colors.white,
                    ),
                    SizedBox(height: 15),
                    Custombutton(
                      BtnText: "Continue with Google ",
                      Icons: Icons.article_sharp,
                      onPressd: () {},
                      Background: Colors.white,
                      foreBacground: const Color.fromARGB(255, 70, 69, 69),
                    ),
                    Customdivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        SizedBox(width: 4),
                        Text(
                          "Create one",
                          style: TextStyle(fontWeight: FontWeight.w600),
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
    );
  }
}
