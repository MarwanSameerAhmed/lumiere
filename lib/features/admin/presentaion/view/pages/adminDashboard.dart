import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementCards.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:provider/provider.dart';

class Admindashboard extends StatelessWidget {
  const Admindashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning,",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text("Admin", style: TextStyle(fontSize: 30)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF0EDE4),
                        ),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffF0EDE4),
                          ),
                          child: const CircleAvatar(radius: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Adminmanagementcards(
                Title: 'Product Management',
                color: Color(0xffF0EDE4),
                icon: Icons.local_shipping,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.productManagement);
                },
              ),
              SizedBox(height: 15),
              Adminmanagementcards(
                Title: 'Categories Management',
                color: Color(0xffF0EDE4),
                icon: Icons.category,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.AdminCategoriesManagement,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    bool isLoggingOut = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.KSecoundaryBackgroundColor,
            title: const Text(
              'Logout',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to sign out of your account?',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: isLoggingOut ? null : () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // نفس لون زر الحذف للتنبيه
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: isLoggingOut
                    ? null
                    : () async {
                        setState(() => isLoggingOut = true);
                        try {
                          final auth = Provider.of<Authprovider>(
                            context,
                            listen: false,
                          );
                          final succ = await auth.signout();

                          if (context.mounted) {
                            if (succ) {
                              // العودة لصفحة تسجيل الدخول ومسح السجل
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRouter.login,
                                (route) => false,
                              );
                            } else {
                              setState(() => isLoggingOut = false);
                              // اختياري: إظهار خطأ في حال فشل تسجيل الخروج
                            }
                          }
                        } catch (e) {
                          setState(() => isLoggingOut = false);
                        }
                      },
                child: isLoggingOut
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
