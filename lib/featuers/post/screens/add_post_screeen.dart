import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mti_communities/featuers/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

import '../../../theme/pallete.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  navigateToTypePostScreen(String type, BuildContext context) {
    Routemaster.of(context).push("/add-post/$type");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double sizedBoxsSize = 120;
    final double iconSize = 60;
    final currentTheme = ref.watch(themeNotiferProvider);
    final user = ref.watch(usersProvider)!;
    return user.isbaned
        ? Center(
            child: Text("Your Account Is Banned"),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => navigateToTypePostScreen("image", context),
                child: SizedBox(
                  height: sizedBoxsSize,
                  width: sizedBoxsSize,
                  child: Card(
                    color: currentTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Icon(
                      Icons.image_outlined,
                      size: iconSize,
                    )),
                    elevation: 16,
                  ),
                ),
              ),
              InkWell(
                onTap: () => navigateToTypePostScreen("text", context),
                child: SizedBox(
                  height: sizedBoxsSize,
                  width: sizedBoxsSize,
                  child: Card(
                    color: currentTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Icon(
                      Icons.font_download_outlined,
                      size: iconSize,
                    )),
                    elevation: 16,
                  ),
                ),
              ),
              InkWell(
                onTap: () => navigateToTypePostScreen("link", context),
                child: SizedBox(
                  height: sizedBoxsSize,
                  width: sizedBoxsSize,
                  child: Card(
                    color: currentTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Icon(
                      Icons.link_outlined,
                      size: iconSize,
                    )),
                    elevation: 16,
                  ),
                ),
              )
            ],
          );
  }
}
