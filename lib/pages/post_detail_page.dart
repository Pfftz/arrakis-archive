import 'package:flutter/material.dart';
import 'package:pemrograman_sistem_mobile/pages/comment_page.dart';
import 'package:pemrograman_sistem_mobile/models/model_post.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c1810),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Arrakis Chronicles',
              style: TextStyle(
                color: Color(0xFFe79b07),
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Dune',
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3d2d1c),
        elevation: 2,
        shadowColor: const Color(0xFFb29254),
        iconTheme: const IconThemeData(color: Color(0xFFe79b07)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/banner.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(44, 24, 16, 0.8),
                Color.fromRGBO(26, 15, 8, 0.9),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(height: 24),
                  _PostContent(post: post),
                  const SizedBox(height: 32),
                  _PostActions(post: post),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3d2d1c),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFb29254).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFb29254), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFe79b07).withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF2c1810),
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200/200?random=${post.id}',
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                  child: Text(
                    post.id.toString(),
                    style: const TextStyle(
                      color: Color(0xFFe79b07),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'User ${post.userId}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFe79b07),
                            ),
                          ),
                          TextSpan(
                            text: ' • Arrakis Citizen',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(
                                0xFFb29254,
                              ).withValues(alpha: 0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFb29254).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Post #${post.id}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFb29254),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFb29254), thickness: 1),
          const SizedBox(height: 16),
          Text(
            post.title,
            style: const TextStyle(
              color: Color(0xFFe79b07),
              fontWeight: FontWeight.bold,
              fontSize: 24,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final Post post;

  const _PostContent({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3d2d1c),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFb29254).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.article_outlined,
                color: const Color(0xFFb29254),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Chronicle Content',
                style: const TextStyle(
                  color: Color(0xFFb29254),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            post.body,
            style: const TextStyle(
              color: Color(0xFFf5f5dc),
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  final Post post;

  const _PostActions({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3d2d1c),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFb29254).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _QuickActionButton(
                icon: Icons.thumb_up_outlined,
                label: 'Like',
                count: post.id * 3,
                onPressed: () {},
              ),
              _QuickActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                count: post.id,
                onPressed: () {},
              ),
              _QuickActionButton(
                icon: Icons.bookmark_border,
                label: 'Save',
                count: 0,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentPage(postId: post.id),
                  ),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('View Desert Voices'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe79b07),
                foregroundColor: const Color(0xFF3d2d1c),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFb29254), size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFb29254),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(height: 2),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Color(0xFFe79b07),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
