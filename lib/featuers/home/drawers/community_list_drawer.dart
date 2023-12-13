import 'package:cached_network_image/cached_network_image.dart';
import 'package:mti_communities/core/common/error_text.dart';
import 'package:mti_communities/core/common/loader.dart';
import 'package:mti_communities/core/common/sign_in_button.dart';
import 'package:mti_communities/core/constants/constants.dart';
import 'package:mti_communities/featuers/community/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

import '../../../models/community_model.dart';
import '../../auth/controller/auth_controller.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
    print(community.name);
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
                  ListTile(
                    title: const Text('Create a community'),
                    leading: const Icon(Icons.add),
                    onTap: () => navigateToCreateCommunity(context),
                  ),
                  ref.watch(UserCommunityProvider).when(
                      data: (communites) => Expanded(
                            child: ListView.builder(
                                itemCount: communites.length,
                                itemBuilder: (context, index) {
                                  final community = communites[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: community.avatar !=
                                              Constants.avatarDefault
                                          ? CachedNetworkImageProvider(
                                              community.avatar)
                                          : CachedNetworkImageProvider(
                                              Constants.avatarDefault),
                                    ),
                                    title: Text("r/${community.name}"),
                                    onTap: () {
                                      navigateToCommunity(context, community);
                                    },
                                  );
                                }),
                          ),
                      error: (error, StackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => const Loader())
                ],
              ),
      ),
    );
  }
}
