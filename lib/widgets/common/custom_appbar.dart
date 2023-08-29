import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/screens/question/test_overview_screen.dart';
import 'package:quizzems/widgets/app_circle_button.dart';
import 'package:quizzems/widgets/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final Widget? leading;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.showActionIcon = false,
      this.leading,
      this.onMenuActionTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobileScreenPadding,
        vertical: mobileScreenPadding,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: titleWidget == null
                ? Center(
                    child: Text(
                      title,
                      style: appBarTS,
                    ),
                  )
                : Center(
                    child: titleWidget,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcon)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: AppCircleButton(
                    onTap: onMenuActionTap ??
                        () => Get.toNamed(TestOverviewScreen.routeName),
                    child: const Icon(AppIcons.menu),
                  ),
                )
            ],
          )
        ],
      ),
    ));
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize

  Size get preferredSize => const Size(double.maxFinite, 80);
}
