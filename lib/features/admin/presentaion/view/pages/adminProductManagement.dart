import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:provider/provider.dart';

class productManagement extends StatelessWidget {
  const productManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good morning,",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text("Product Management", style: TextStyle(fontSize: 30)),
              ],
            ),
            //     Row(
            //       children: [
            //         Container(
            //           padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             color: Color(0xffF0EDE4),
            //           ),
            //           child: Icon(Icons.notifications_outlined),
            //         ),
            //         SizedBox(width: 5),
            //         Container(
            //           padding: EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             color: Color(0xffF0EDE4),
            //           ),
            //           child: CircleAvatar(radius: 16),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Consumer<Homeprovider>(
              builder: (context, value, child) {
                if (value.isLoadingpro)
                  return Center(child: CircularProgressIndicator());
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.product.length,
                    itemBuilder: (context, index) {
                      final pro = value.product[index];
                      return ListTile(
                        leading: Image.memory(base64Decode('')),
                        title: Text(pro.ProductName),
                        subtitle: Text(pro.Description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.KMainBackgroundButtonColor,
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.Addnewproduct);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
