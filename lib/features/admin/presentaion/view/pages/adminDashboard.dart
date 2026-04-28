import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementCards.dart';

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
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF0EDE4),
                        ),
                        child: CircleAvatar(radius: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
