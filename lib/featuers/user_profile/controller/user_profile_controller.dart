import 'dart:io';

import 'package:mti_communities/core/enums/message_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums/enums.dart';

import '../../../core/providers/storage_repository.dart';
import '../../../core/utils.dart';
import '../../../models/chat_model.dart';
import '../../../models/message_model.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../chats/repositories/messages_reply.dart';
import '../repositories/user_profile_repository.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userProfileRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return UserProfileController(
    userProfileRepository: userProfileRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final getUserPostsProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(userProfileControllerProvider.notifier).getUserPosts(uid);
});

final getUserChatsProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(userProfileControllerProvider.notifier).getUserchats(uid);
});

final getUserMessagesProviderr = StreamProvider.family((ref, String uid) {
  return ref.watch(userProfileControllerProvider.notifier).getMessages(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editProfile({
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
    required String name,
  }) async {
    state = true;
    UserModel user = _ref.read(usersProvider)!;

    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: user.uid,
        file: profileFile,
      );
      res.fold(
        (l) => showSnackBar(l.message, context),
        (r) => user = user.copyWith(profilePic: r),
      );
    }

    if (bannerFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'users/banner',
        id: user.uid,
        file: bannerFile,
      );
      res.fold(
        (l) => showSnackBar(l.message, context),
        (r) => user = user.copyWith(banner: r),
      );
    }

    user = user.copyWith(name: name);
    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(l.message, context),
      (r) {
        _ref.read(usersProvider.notifier).update((state) => user);
        Routemaster.of(context).pop();
      },
    );
  }

  Stream<List<Post>> getUserPosts(String uid) {
    return _userProfileRepository.getUserPosts(uid);
  }

  Stream<List<Chats>> getUserchats(String uid) {
    return _userProfileRepository.getUserchats(uid);
  }

  Stream<List<Message>> getMessages(String uid) {
    final curr = _ref.read(usersProvider)!.uid;
    return _userProfileRepository.getMessages(curr, uid);
  }

  Future<void> loadMessages() async {
    _userProfileRepository.loadMessages();
  }

  void sendText(String text, String reciverUserId, BuildContext context) async {
    UserModel senderUser = _ref.read(usersProvider)!;
    var messagesReply = _ref.read(messageReplyProvider);

    if (messagesReply == null) {
      messagesReply = MessagesReply("", false, MessageEnum.text);
    }

    final res = await _userProfileRepository.sendTextMessage(
      text,
      reciverUserId,
      senderUser,
      Uuid().v1(),
      messagesReply,
    );
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void updataKarma(UserKarma karma) async {
    UserModel user = _ref.read(usersProvider)!;
    user = user.copyWith(karma: user.karma + karma.karma);
    final res = await _userProfileRepository.updateKarma(user);

    res.fold((l) => null,
        (r) => _ref.read(usersProvider.notifier).update((state) => user));
  }

  void follow(UserModel usermodel, BuildContext context) async {
    final user = _ref.read(usersProvider)!;

    var res;
    if (usermodel.followers.contains(user.uid)) {
      res = (await _userProfileRepository.unfollow(user.uid, usermodel.uid));
    } else {
      res = (await _userProfileRepository.follow(user.uid, usermodel.uid));
    }

    res.fold((l) => showSnackBar(l.message, context), (r) {});
  }
}
