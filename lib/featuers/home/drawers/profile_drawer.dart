import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void logOut(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).logOut();
  }

  void updateTheme(WidgetRef ref) {
    ref.read(themeNotiferProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersProvider)!;

    return Drawer(
      child: SafeArea(
        child: user.isbaned
            ? Center(
                child: Text("Your Account Is Banned"),
              )
            : Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(user.profilePic),
                    radius: 70,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'u/${user.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  ListTile(
                    title: const Text('My Profile'),
                    leading: const Icon(Icons.person),
                    onTap: () => navigateToUserProfile(context, user.uid),
                  ),
                  ListTile(
                    title: const Text('Log Out'),
                    leading: Icon(
                      Icons.logout,
                      color: Pallete.redColor,
                    ),
                    onTap: () => logOut(ref),
                  ),
                  Switch.adaptive(
                    value: ref.watch(themeNotiferProvider.notifier).mode ==
                        ThemeMode.dark,
                    onChanged: (val) => updateTheme(ref),
                  ),
                ],
              ),
      ),
    );
  }
}
