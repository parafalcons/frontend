// lib/main.dart
import 'package:flutter/material.dart';

import 'message_screen.dart';
import 'notification_screen.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Post List Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PostListScreen(),
//     );
//   }
// }

class PostListScreen extends StatelessWidget {
  final List<Post> posts = DummyData.posts;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(
          'KnowReel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: colorScheme.onSurface),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationScreen(),
                ),
              );


            },
          ),
          IconButton(
            icon: Icon(Icons.message, color: colorScheme.onSurface),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserListScreen(),
                ),
              );

            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: posts.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(post.avatarUrl),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${post.readTime} • ${post.date}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white70),
            ],
          ),
          SizedBox(height: 10),

          // Title
          Text(
            post.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 10),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                post.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),

          // Actions row
          Row(
            children: [
              _ActionWithCount(
                icon: Icons.favorite_border,
                count: post.likes,
              ),
              SizedBox(width: 12),
              _ActionWithCount(
                icon: Icons.mode_comment_outlined,
                count: post.comments,
              ),
              Spacer(),
              Icon(Icons.share_outlined, color: Colors.white70),
              SizedBox(width: 4),
              Icon(Icons.bookmark_border, color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionWithCount extends StatelessWidget {
  final IconData icon;
  final int count;
  const _ActionWithCount({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        SizedBox(width: 6),
        Text(
          count.toString(),
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}

/// --- Model & Dummy Data ---
class Post {
  final String author;
  final String avatarUrl;
  final String readTime;
  final String date;
  final String title;
  final String imageUrl;
  final int likes;
  final int comments;

  Post({
    required this.author,
    required this.avatarUrl,
    required this.readTime,
    required this.date,
    required this.title,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });
}

class DummyData {
  static final List<Post> posts = [
    Post(
      author: 'Kelly Vishwas',
      avatarUrl: 'https://i.pravatar.cc/100?img=32',
      readTime: '12m read time',
      date: 'Aug 19',
      title: 'The game in Japan was amazing and I want to share some photos',
      imageUrl: 'https://picsum.photos/800/450?image=1050',
      likes: 1289,
      comments: 42,
    ),
    Post(
      author: 'Aria Thompson',
      avatarUrl: 'https://i.pravatar.cc/100?img=12',
      readTime: '5m read time',
      date: 'Sep 02',
      title: 'Quick notes about the new design system rollout',
      imageUrl: 'https://picsum.photos/800/450?image=1043',
      likes: 342,
      comments: 18,
    ),
    Post(
      author: 'Rajat Sharma',
      avatarUrl: 'https://i.pravatar.cc/100?img=45',
      readTime: '8m read time',
      date: 'Oct 01',
      title: '3 tips that changed how I structure Flutter apps',
      imageUrl: 'https://picsum.photos/800/450?image=1067',
      likes: 891,
      comments: 67,
    ),
    Post(
      author: 'Maya Singh',
      avatarUrl: 'https://i.pravatar.cc/100?img=7',
      readTime: '3m read time',
      date: 'Nov 12',
      title: 'Behind the scenes of our latest photo shoot',
      imageUrl: 'https://picsum.photos/800/450?image=1021',
      likes: 214,
      comments: 9,
    ),
    Post(
      author: 'Sam Wilson',
      avatarUrl: 'https://i.pravatar.cc/100?img=9',
      readTime: '10m read time',
      date: 'Dec 05',
      title: 'Why we migrated to a microfrontend architecture',
      imageUrl: 'https://picsum.photos/800/450?image=1015',
      likes: 540,
      comments: 24,
    ),
  ];
}