import 'package:mti_communities/featuers/auth/controller/auth_controller.dart';
import 'package:mti_communities/featuers/community/controller/community_controller.dart';
import 'package:mti_communities/featuers/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersProvider)!;
    return user.isbaned
        ? Center(
            child: Text("Your Account Is Banned"),
          )
        : ref.watch(UserCommunityProvider).when(
            data: (community) => ref.watch(getPostsProvider(community)).when(
                skipLoadingOnRefresh: true,
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
            error: (error, StackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader());
  }
}
