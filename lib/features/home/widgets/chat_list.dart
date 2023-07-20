import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsup/common/models/user.dart';
import 'package:whatsup/common/theme.dart';
import 'package:whatsup/common/util/ext.dart';
import 'package:whatsup/common/widgets/error.dart';
import 'package:whatsup/common/widgets/progress.dart';
import 'package:whatsup/features/auth/controllers/auth.dart';
import 'package:whatsup/features/chat/controller/chat_controller.dart';
import 'package:whatsup/features/chat/widgets/chat_tile.dart';
import 'package:whatsup/router.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveChats = ref.watch(chatsStreamProvider);
    final liveGroups = ref.watch(groupsStreamProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          liveChats.when(
            data: (chats) {
              if (chats.isEmpty) {
                return const Center(
                  child: Text('No chats yet'),
                );
              }
              return ListView.builder(
                itemCount: chats.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final liveMessages = ref.watch(messagesStreamProvider(chat.receiverId));
                  return liveMessages.when(
                    data: (messages) {
                      final unread = messages.where((msg) {
                        return msg.recvId ==
                                ref.read(authControllerProvider).currentUser.unwrap().uid &&
                            !msg.isRead;
                      }).length;
                      return ChatListTile(
                        name: chat.name,
                        lastMessage: chat.lastMessage,
                        lastMessageTime: chat.lastMessageTime,
                        avatarImage: chat.profileImage,
                        unreadMessages: unread,
                        onTap: () {
                          onChatTap(
                            receiver: chat.receiverId,
                            name: chat.name,
                            image: chat.profileImage,
                            context: context,
                            isGroup: false,
                          );
                        },
                      );
                    },
                    error: (err, trace) => UnhandledError(error: err.toString()),
                    loading: () => const WorkProgressIndicator(),
                  );
                },
              );
            },
            error: (err, trace) => UnhandledError(error: err.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          liveGroups.when(
            data: (groups) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return ChatListTile(
                      name: group.name,
                      lastMessage: group.lastMessage,
                      lastMessageTime: group.lastMessageTime,
                      avatarImage: group.groupImage,
                      unreadMessages: 0,
                      onTap: () {
                        onChatTap(
                          receiver: group.groupId,
                          name: group.name,
                          image: group.groupImage,
                          context: context,
                          isGroup: true,
                        );
                      });
                },
              );
            },
            error: (error, trace) => UnhandledError(error: error.toString()),
            loading: () => const WorkProgressIndicator(),
          ),
        ],
      ),
    );
  }

  void onChatTap({
    required String receiver,
    required String name,
    required String image,
    required BuildContext context,
    required bool isGroup,
  }) {
    Navigator.pushNamed(context, PageRouter.chat, arguments: {
      'isGroup': isGroup,
      'streamId': receiver,
      'name': name,
      'avatarImage': image,
    });
  }
}
