import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/admin/presentaion/manager/AdminProvider.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:provider/provider.dart';

class AdminCategoriesManagement extends StatelessWidget {
  const AdminCategoriesManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Adminmanagementheader(Title: 'Categories Gallery'),
            const SizedBox(height: 25),
            Expanded(
              child: Consumer2<Homeprovider, Adminprovider>(
                builder: (context, homeProvider, adminProvider, child) {
                  if (homeProvider.isLoadingcat) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (homeProvider.category.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: homeProvider.category.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final cat = homeProvider.category[index];
                      return _buildCategoryCard(context, cat, adminProvider);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.KMainBackgroundButtonColor,
        onPressed: () => Navigator.pushNamed(context, AppRouter.Addnewcategory),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'New Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    dynamic cat,
    Adminprovider adminProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.KMainBackgroundButtonColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              getIconFromString(cat.icon),
              color: AppColors.KMainBackgroundButtonColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // اسم التصنيف
          Expanded(
            child: Text(
              cat.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          _buildCircleAction(
            icon: Icons.edit_rounded,
            color: Colors.blue,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _buildCircleAction(
            icon: Icons.delete_outline_rounded,
            color: Colors.redAccent,
            onTap: () => _showDeleteDialog(context, adminProvider, cat.ID),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAction({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.5,
            child: Icon(
              Icons.category_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No categories added yet',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    Adminprovider adminProvider,
    String catId,
  ) {
    bool isDeleting = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: AppColors.KSecoundaryBackgroundColor,
            title: const Text('Confirm Delete', textAlign: TextAlign.center),
            content: const Text(
              'Are you sure you want to remove this category?',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: isDeleting ? null : () => Navigator.pop(context),
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
                  backgroundColor: Colors.redAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isDeleting
                    ? null
                    : () async {
                        setState(() => isDeleting = true);
                        try {
                          await adminProvider.deleteCategory(catId);
                          if (context.mounted) {
                            await Provider.of<Homeprovider>(
                              context,
                              listen: false,
                            ).fetchAllCategoryies();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Category deleted'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() => isDeleting = false);
                        }
                      },
                child: isDeleting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Delete',
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

  IconData getIconFromString(String icons) {
    switch (icons) {
      case 'shirt':
        return Icons.dry_cleaning;
      case 'ring':
        return Icons.ring_volume;
      case 'bag':
        return Icons.local_shipping_outlined;
      case 'all':
        return Icons.menu_outlined;
      default:
        return Icons.category;
    }
  }
}
