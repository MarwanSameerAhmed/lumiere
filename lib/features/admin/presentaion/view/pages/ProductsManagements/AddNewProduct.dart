import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/widgets/massageToast.dart';
import 'package:lumiere/features/admin/presentaion/manager/AdminProvider.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customButton.dart';
import 'package:lumiere/features/auth/presentation/view/widgets/customTextfield.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:lumiere/features/notifications/presentaion/manager/notificationProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Addnewproduct extends StatefulWidget {
  Addnewproduct({super.key});

  @override
  State<Addnewproduct> createState() => _AddnewproductState();
}

class _AddnewproductState extends State<Addnewproduct> {
  TextEditingController name = TextEditingController();

  TextEditingController dis = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController stock = TextEditingController();

  String? SelectedCategory;

  File? _imageFile;
  String? _base64String;

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickimage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickimage != null) {
      setState(() {
        _imageFile = File(pickimage.path);
        List<int> imageByte = _imageFile!.readAsBytesSync();
        _base64String = base64Encode(imageByte);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<Homeprovider>(context, listen: false).fetchAllCategoryies();
    });
  }

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
              child: Adminmanagementheader(Title: 'Add New Products'),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Customtextfield(
                    HintText: 'Enter Product Name',
                    perfix: Icons.add,
                    controller: name,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),
                  Customtextfield(
                    HintText: 'Enter Product description',
                    perfix: Icons.description,
                    controller: dis,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),

                  Customtextfield(
                    HintText: 'Enter Product price',
                    perfix: Icons.price_change,
                    controller: price,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),

                  Customtextfield(
                    HintText: 'Enter Product Stock',
                    perfix: Icons.numbers,
                    controller: stock,
                    isPassword: false,
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Consumer<Homeprovider>(
                          builder: (context, value, child) {
                            if (value.category.isEmpty)
                              return Center(child: CircularProgressIndicator());
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Select category',
                                border: OutlineInputBorder(),
                              ),
                              value: SelectedCategory,
                              items: value.category.map((cat) {
                                return DropdownMenuItem<String>(
                                  value: cat.ID,
                                  child: Text(cat.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  SelectedCategory = value;
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(),
                            ),
                            child: _imageFile == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image),
                                      Text("select an image"),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
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
                          final newPro = Products(
                            Uid: Uuid().v4(),
                            ProductName: name.text.trim(),
                            price: price.text.trim(),
                            imageUrl: _base64String!,
                            Description: dis.text.trim(),
                            CategoryId: SelectedCategory!,
                            stock: stock.text.trim(),
                          );

                          final succ = await value.addProduct(newPro);
                          if (succ) {
                            if (context.mounted) {
                              await Provider.of<Homeprovider>(
                                context,
                                listen: false,
                              ).fetchAllProduct();
                            }
                            if (context.mounted) {
                              await Provider.of<Notificationprovider>(
                                context,
                                listen: false,
                              ).nottifyallusers(
                                title: "New Product Added",
                                body:
                                    "A new product named ${newPro.ProductName} has been added.",
                              );
                            }

                            Massagetoast.show(msg: "Done!", isError: false);
                            if (context.mounted) Navigator.pop(context);
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
