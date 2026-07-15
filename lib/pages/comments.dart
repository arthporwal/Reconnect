import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/widgets/firestore.dart';

class Comments extends StatefulWidget {
  final String postId;

  const Comments({super.key, required this.postId});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final PostService _postService = PostService();
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  Icon(Icons.lock_outline,
                      color: Color.fromARGB(255, 58, 116, 98)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Join the conversation. Every comment is anonymous.',
                      style: TextStyle(color: Color(0xFF3D5149)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildComments()),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildComments() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _postService.commentsForPost(widget.postId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Unable to load comments. Please try again.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final comments = snapshot.data?.docs ?? [];
        if (comments.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.forum_outlined,
                      size: 52, color: Color(0xFF3A7462)),
                  SizedBox(height: 14),
                  Text(
                    'No comments yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Be the first to leave a kind, anonymous comment.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          itemCount: comments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final text = comments[index].data()['text']?.toString() ?? '';
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 8,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0x1F3A7462),
                          child: Icon(Icons.person_outline,
                              size: 18, color: Color(0xFF3A7462)),
                        ),
                        SizedBox(width: 10),
                        Text('Anonymous',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(text,
                        style: const TextStyle(fontSize: 16, height: 1.35)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildComposer() {
    return Material(
      color: Colors.white,
      elevation: 12,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write an anonymous comment…',
                    filled: true,
                    fillColor: const Color(0xFFF4F8F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: _isSending ? null : _sendComment,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 165, 139),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendComment() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSending = true);
    try {
      await _postService.saveComment(widget.postId, text);
      _controller.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to post comment. Try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}
