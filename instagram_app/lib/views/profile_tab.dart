import 'package:flutter/material.dart';
import 'package:instagram_app/views/edit_profile_screen.dart';
import 'package:instagram_app/views/settings_screen.dart';


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  // Dummy posts
  List<Map<String, String>> _posts() => List.generate(6, (i) {
    return {
      'title': 'Artificial Intelligence is making the difference...',
      'subtitle': 'fsbv hchchdsvhhhghhjvgvgv',
      'date': '23, Aug 2025',
      'image': 'https://picsum.photos/seed/post$i/800/450'
    };
  });

  @override
  Widget build(BuildContext context) {
    final posts = _posts();

    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'alex.mason',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // push settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsCenterPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SizedBox(height: 12),

          // Avatar with posts chip (centered)
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: 46,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                ),
                Positioned(
                  left: -16,
                  top: -12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Text(
                      '46 Posts',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Name, role, bio and link
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const Text(
                  'Jack Stone | Freelancer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Digital goodies designer @pixsellz\nEverything is designed.',
                  style: TextStyle(color: Colors.white70, height: 1.2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    // launch url
                  },
                  child: const Text(
                    'https://youtu.be/7mr1uF4DZFosi',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons: Edit Profile + New Post
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: _GradientButton(
                    text: 'Edit Profile',
                    icon: Icons.edit,
                    onTap: () {
                      // navigate to edit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(),
                        ),
                      );

                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _GradientButton(
                    text: 'New Post',
                    icon: Icons.add,
                    onTap: () {
                      // new post
                    },
                    reversed: true,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Tabs row (grid/video) + filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.grid_on, color: Colors.white70),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.video_collection_outlined,
                      color: Colors.white30),
                  onPressed: () {},
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    // filter
                  },
                  icon: const Icon(Icons.filter_list_outlined,
                      color: Colors.white),
                  label: const Text('Filter',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Posts list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: posts.map((p) {
                return _PostCard(
                  title: p['title'] ?? '',
                  subtitle: p['subtitle'] ?? '',
                  date: p['date'] ?? '',
                  imageUrl: p['image'] ?? '',
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Grid images
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    "https://picsum.photos/id/${index + 10}/200/200",
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool reversed;
  final VoidCallback onTap;
  const _GradientButton({
    required this.text,
    required this.icon,
    required this.onTap,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = reversed
        ? const LinearGradient(colors: [Color(0xFF15E0A8), Color(0xFF8B5CFF)])
        : const LinearGradient(colors: [Color(0xFF8B5CFF), Color(0xFF15E0A8)]);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String date;
  const _PostCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0E0E0E),
      margin: const EdgeInsets.only(bottom: 12),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // headline row
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 6, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(date,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          // image
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}


// Dummy Followers List Screen
class FollowersListScreen extends StatelessWidget {
  final List<Map<String, String>> followers;
  FollowersListScreen({required this.followers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar(context, 'Followers'),

      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final item = followers[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(item["avatar"]!)),
            title: Text(item["username"]!, style: TextStyle(color: Colors.white)),
            subtitle: Text(item["name"]!, style: TextStyle(color: Colors.white54)),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text("Follow back",style: TextStyle(color: Colors.white),),
            ),
          );
        },
      ),
    );
  }
}

// Dummy Following List Screen
class FollowingListScreen extends StatelessWidget {
  final List<Map<String, String>> following;
  FollowingListScreen({required this.following});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, 'Following'),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: following.length,
        itemBuilder: (context, index) {
          final item = following[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(item["avatar"]!)),
            title: Text(item["username"]!, style: TextStyle(color: Colors.white)),
            subtitle: Text(item["name"]!, style: TextStyle(color: Colors.white54)),
            trailing: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white24),
                foregroundColor: Colors.white,
              ),
              child: Text("Message"),
            ),
          );
        },
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context, String title) {
  var colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    centerTitle: true,
    backgroundColor: colorScheme.surface,
    elevation: 0,
    title: Text(title,     style: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),),
    leading: Navigator.canPop(context)
        ? BackButton(color: Colors.white)
        : null,
  );
}


// class ProfileTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Profile Tab'));
//   }
// }
