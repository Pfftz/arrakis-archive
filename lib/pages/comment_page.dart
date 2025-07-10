import 'package:flutter/material.dart';
import 'package:pemrograman_sistem_mobile/controllers/controller_comment.dart';
import 'package:pemrograman_sistem_mobile/models/model_comment.dart';

class CommentPage extends StatefulWidget {
  final int postId;

  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late Future<List<Comment>> futureComments;

  @override
  void initState() {
    super.initState();
    futureComments = fetchComments(widget.postId);
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
              'Arrakis Voices',
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
            image: AssetImage('assets/images/1.jpg'),
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
          child: FutureBuilder<List<Comment>>(
            future: futureComments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFe79b07),
                    ),
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
                final comments = snapshot.data!;
                return Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: comments.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return _CommentCard(comment: comment, index: index);
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
                          Icons.chat_bubble_outline,
                          color: Color(0xFFb29254),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The desert is silent...',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: const Color(0xFFe79b07)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No voices echo across the dunes.',
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

class _CommentCard extends StatelessWidget {
  final Comment comment;
  final int index;

  const _CommentCard({required this.comment, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            _AvatarImage(index),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CommentHeader(comment: comment),
                  const SizedBox(height: 12),
                  _CommentBody(comment: comment),
                  const SizedBox(height: 16),
                  _CommentActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final int index;

  const _AvatarImage(this.index);

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://picsum.photos/200/200?random=${index + 1}';

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
        backgroundImage: NetworkImage(imageUrl),
        onBackgroundImageError: (exception, stackTrace) {
          print('Error loading image: $exception');
        },
        child: Text(
          '${index + 1}',
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

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  const _CommentHeader({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: comment.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFe79b07),
                    fontFamily: 'DidoLT',
                  ),
                ),
                TextSpan(
                  text: ' • Fremen',
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
            '${comment.id}m',
            style: const TextStyle(fontSize: 12, color: Color(0xFFb29254)),
          ),
        ),
      ],
    );
  }
}

class _CommentBody extends StatelessWidget {
  final Comment comment;

  const _CommentBody({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF2c1810).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFb29254).withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            comment.email,
            style: const TextStyle(
              color: Color(0xFFb29254),
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          comment.body,
          style: const TextStyle(
            color: Color(0xFFf5f5dc),
            fontSize: 15,
            height: 1.4,
            fontFamily: 'Futura',
          ),
        ),
      ],
    );
  }
}

class _CommentActions extends StatelessWidget {
  const _CommentActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.thumb_up_outlined,
          count: 0,
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        _ActionButton(icon: Icons.reply_outlined, count: 0, onPressed: () {}),
        const SizedBox(width: 16),
        _ActionButton(icon: Icons.share_outlined, count: 0, onPressed: () {}),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.more_horiz,
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
