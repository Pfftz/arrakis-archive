import 'package:flutter/material.dart';
import 'package:pemrograman_sistem_mobile/models/model_post.dart';
import 'package:pemrograman_sistem_mobile/pages/post_detail_page.dart';
import 'package:pemrograman_sistem_mobile/controllers/controller_post.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

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
              'Arrakis Archives',
              style: TextStyle(
                color: Color(0xFFe79b07),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Dune',
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3d2d1c),
        elevation: 2,
        shadowColor: const Color(0xFFb29254),
        centerTitle: true,
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
            image: AssetImage('assets/images/2.jpg'),
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
          child: FutureBuilder<List<Post>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFe79b07),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading chronicles from the desert...',
                        style: TextStyle(
                          color: Color(0xFFb29254),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3d2d1c),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFb29254),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFe79b07),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The spice flow has been interrupted...',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: const Color(0xFFe79b07)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Error: ${snapshot.error}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFFb29254)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final posts = snapshot.data!;
                return Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: posts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return _PostCard(post: post, index: index);
                    },
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3d2d1c),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFb29254),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.library_books_outlined,
                          color: Color(0xFFb29254),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The archives are empty...',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: const Color(0xFFe79b07)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No chronicles found in the desert sands.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFFb29254)),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;
  final int index;

  const _PostCard({required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostAvatar(post: post),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PostHeader(post: post),
                    const SizedBox(height: 12),
                    _PostContent(post: post),
                    const SizedBox(height: 16),
                    _PostActions(post: post),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostAvatar extends StatelessWidget {
  final Post post;

  const _PostAvatar({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
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
                  text: ' • Desert Chronicler',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFb29254).withValues(alpha: 0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFb29254).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${post.id}h',
            style: const TextStyle(fontSize: 12, color: Color(0xFFb29254)),
          ),
        ),
      ],
    );
  }
}

class _PostContent extends StatelessWidget {
  final Post post;

  const _PostContent({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: const TextStyle(
            color: Color(0xFFe79b07),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          post.body,
          style: const TextStyle(
            color: Color(0xFFf5f5dc),
            fontSize: 14,
            height: 1.4,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _PostActions extends StatelessWidget {
  final Post post;

  const _PostActions({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          count: post.id * 2,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailPage(post: post),
              ),
            );
          },
        ),
        const SizedBox(width: 16),
        _ActionButton(
          icon: Icons.thumb_up_outlined,
          count: post.id * 3,
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        _ActionButton(
          icon: Icons.share_outlined,
          count: post.id,
          onPressed: () {},
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.bookmark_border,
            color: Color(0xFFb29254),
            size: 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: const Color(0xFFb29254)),
      label: count > 0
          ? Text(
              count.toString(),
              style: const TextStyle(color: Color(0xFFb29254), fontSize: 12),
            )
          : const SizedBox.shrink(),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
