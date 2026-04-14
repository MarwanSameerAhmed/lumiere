import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customButton.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customTextfield.dart';
import 'package:provider/provider.dart';

class Resetpassword extends StatelessWidget {
  Resetpassword({super.key});
  TextEditingController email = TextEditingController();

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
                            "Verify Your Account!",
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
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Customtextfield(
                      HintText: "Enter Your Email",
                      perfix: Icons.email_outlined,
                      controller: email,
                      isPassword: false,
                    ),

                    SizedBox(height: 15),

                    Consumer<Authprovider>(
                      builder: (context, auth, child) {
                        return Column(
                          children: [
                            if (auth.errorMassage != null)
                              Text(
                                auth.errorMassage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(height: 10),

                            auth.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Custombutton(
                                    BtnText: "Send to Verify ",
                                    Icons: Icons.article_sharp,
                                    onPressd: () async {
                                      final success = await auth
                                          .userResetpassword(
                                            email: email.text.trim(),
                                          );
                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    Background:
                                        AppColors.KMainBackgroundButtonColor,
                                    foreBacground: Colors.white,
                                  ),
                          ],
                        );
                      },
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
