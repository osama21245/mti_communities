import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:mti_communities/core/common/error_text.dart';
import 'package:mti_communities/core/common/loader.dart';
import 'package:mti_communities/featuers/auth/controller/auth_controller.dart';
import 'package:mti_communities/featuers/community/controller/community_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mti_communities/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/post_card.dart';
import '../../../models/community_model.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    prinname() {
      print(name);
    }

    void deleteCommunity(String communityId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('Are You sure deleting this community'),
            actions: [
              TextButton(
                onPressed: () {
                  Routemaster.of(context).pop();
                  ref
                      .watch(communityControllerProvider.notifier)
                      .deleteCommunity(communityId, context);
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    }

    void navigateModTools(BuildContext context) {
      Routemaster.of(context).push('/mod-tools/$name');
    }

    joinCommunity(WidgetRef ref, Community community, BuildContext context) {
      ref
          .watch(communityControllerProvider.notifier)
          .joinCommunity(community, context);
    }

    String decodedname = Uri.decodeComponent(name);

    final user = ref.watch(usersProvider);
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(decodedname)).when(
          data: (community) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                              child: CachedNetworkImage(
                            imageUrl: community.banner,
                            fit: BoxFit.cover,
                          ))
                        ],
                      ),
                      floating: true,
                      snap: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                        Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(community.avatar),
                              radius: 35,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "r/${community.name}",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            community.mods.contains(user!.uid)
                                ? OutlinedButton(
                                    onPressed: () {
                                      navigateModTools(context);
                                    },
                                    child: Text(
                                      "Mod Tools",
                                      style:
                                          TextStyle(color: Pallete.orangeColor),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25)),
                                  )
                                : OutlinedButton(
                                    onPressed: () =>
                                        joinCommunity(ref, community, context),
                                    child: community.members.contains(user.uid)
                                        ? Text("Joined",
                                            style: TextStyle(
                                                color: Pallete.orangeColor))
                                        : Text("Join",
                                            style: TextStyle(
                                                color: Pallete.orangeColor)),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25)),
                                  ),
                            if (user.permission == 2)
                              OutlinedButton(
                                onPressed: () => deleteCommunity(community.id),
                                child: Icon(Icons.key),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25)),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("${community.members.length} members"),
                        )
                      ])),
                    )
                  ];
                },
                body: ref.watch(getComunityPostsProvider(decodedname)).when(
                    data: (posts) {
                      return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return PostCard(
                              post: post,
                            );
                          });
                    },
                    error: (error, StackTrace) {
                      print(error);
                      ;
                      return ErrorText(error: error.toString());
                    },
                    loading: () => const Loader()),
              ),
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
