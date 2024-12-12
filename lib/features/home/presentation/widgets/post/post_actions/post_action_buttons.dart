import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/services/share_service.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../../controllers/cubits/post/posts_cubit.dart';
import '../../action_button.dart';
import '../../comment/comments_list.dart';
import '../../test_build_reactions/fb_reaction_box.dart';

class PostActionButtons extends StatelessWidget {
  final PostEntity post;

  const PostActionButtons({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          FbReactionBox(
            post: post,
            onReact: (reactType) => _handleReaction(reactType, context),
          ),
          10.pw(),
          ActionButton(
            iconPath: 'assets/icons/comment.png',
            count: post.commentsCount.toString(),
            onTap: () => CommentsList(postId: post.id, context: context),
          ),
          10.pw(),
          ActionButton(
            iconPath: 'assets/icons/share.png',
            count: '0',
            onTap: () {
              showShareOptions(context,post);
            },
          ),
          const Spacer(),
          SaveButton(
            postId: post.id!,
            isSaved: post.isSaved??false,
            onSave: () => context.read<PostsCubit>().savePost(
              postId: post.id!,
              isSaved: post.isSaved!,
            ),
          ),
        ],
      ),
    );
  }
  void _handleReaction(String reactType, BuildContext context) async {
    try {
      await context.read<PostsCubit>().reactToPost(
        context: context,
        reactType: reactType.toUpperCase(),
        postId: post.id!,
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update reaction')),
      );
    }
  }
}

void sharePost(String postId) {
  final String postUrl = 'https://academex-1.onrender.com/post/$postId';
  Share.share(postUrl, subject: 'Check out this post!');
}

void showShareOptions(BuildContext context,PostEntity post) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 56,
              color: const Color(0xffE7E8EA),
            ),
            20.ph(),
            // Close button and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                100.pw(),

                AppText(
                  text: 'مشاركة بواسطة',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
                // To balance the close icon space
              ],
            ),
            // Sharing options
            20.ph(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              _buildShareOption(
              iconPath: 'assets/icons/copy_link.png',
              label: 'نسخ الرابط',
              onTap: () async {
                await ShareService.copyLink(post.id.toString(), context);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
        _buildShareOption(
          iconPath: 'assets/icons/telegram.png',
          label: 'تلجرام',
          onTap: () async {
            await ShareService.shareViaTelegram(
              post.id.toString(),
              post.content ?? 'منشور مشترك', // Provide a default title if null
            );
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
        _buildShareOption(
          iconPath: 'assets/icons/X.png',
          label: 'تويتر',
          onTap: () async {
            await ShareService.shareViaX(
              post.id.toString(),
              post.content ?? 'منشور مشترك', // Provide a default title if null
            );
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
        _buildShareOption(
          iconPath: 'assets/icons/whatsapp.png',
          label: 'واتساب',
          onTap: () async {
            await ShareService.shareViaWhatsApp(
              post.id.toString(),
              post.content ?? 'منشور مشترك', // Provide a default title if null
            );
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
                ]),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

Widget _buildShareOption(
    {required String iconPath,
      required String label,
      required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 69,
          width: 69,
          decoration: BoxDecoration(
              color: const Color(0xF9F9F9C4),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  iconPath,
                ),
              )),
        ),
        // CircleAvatar(
        //   radius: 28.0,
        //   backgroundColor: Colors.grey.shade200,
        //   child: Image.asset(iconPath, height: 30, width: 30),
        // ),
        const SizedBox(height: 8),
        AppText(
          text: label,
          fontSize: 12,
          color: const Color(0xff3D5A80),
        )
      ],
    ),
  );
}