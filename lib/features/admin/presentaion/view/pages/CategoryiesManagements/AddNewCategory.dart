import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/widgets/massageToast.dart';
import 'package:lumiere/features/admin/presentaion/manager/AdminProvider.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customButton.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customTextfield.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Addnewcategory extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController iconName = TextEditingController();
  Addnewcategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50,
              ),
              child: Adminmanagementheader(Title: 'Add New Category'),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Customtextfield(
                    HintText: 'Enter Category Name',
                    perfix: Icons.add,
                    controller: name,
                    isPassword: false,
                  ),
                  SizedBox(height: 20),

                  Customtextfield(
                    HintText: 'Enter Category Icon',
                    perfix: Icons.add,
                    controller: name,
                    isPassword: false,
                  ),

                  SizedBox(height: 20),

                  Consumer<Adminprovider>(
                    builder: (context, value, child) {
                      if (value.isLoadingPro)
                        return Center(child: CircularProgressIndicator());
                      return Custombutton(
                        BtnText: 'Add',
                        Icons: Icons.add,
                        onPressd: () async {
                          final newPro = Categorys(
                            ID: Uuid().v4(),
                            name: name.text.trim(),
                            icon: iconName.text.trim(),
                          );

                          final succ = await value.addCategory(newPro);
                          if (succ) {
                            Massagetoast.show(msg: "Done!", isError: false);
                            Navigator.pop(context);
                          }
                        },
                        Background: AppColors.KMainBackgroundButtonColor,
                        foreBacground: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
