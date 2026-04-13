import 'package:flutter/material.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            try {
              await AuthRepo().SignOut();
              Navigator.pushNamed(context, AppRouter.login);
            } catch (e) {
              throw Exception(e.toString());
            }
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
