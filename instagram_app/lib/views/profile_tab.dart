import 'package:flutter/material.dart';
import 'package:instagram_app/views/edit_profile_screen.dart';
import 'package:instagram_app/views/settings_screen.dart';


import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  // Dummy profile data for followers/following
  final List<Map<String, String>> followers = List.generate(
    30,
        (i) => {
      "avatar": "https://i.pravatar.cc/150?img=${(i % 70) + 1}",
      "username": [
        "alex.mason",
        "pixelVoyager",
        "codeNectar",
        "DesignDruid",
        "aestheticLoop",
        "byteCrush",
        "craftMuse",
        "tintTheory",
        "buildBard",
        "mockupNomad",
        "uiAlchemy",
        "wireframeWhiz",
        "devDynamo",
        "uxZenith",
        "snappyGrids",
        "neonMockups",
        "swipeSavvy",
        "protoPilot",
        "themeThrive",
        "layerLover",
        "iconicIdeas",
        "layoutLex",
        "colorCraze",
        "stackSynergy",
        "vectorVision",
        "gridGuru",
        "shadeShift",
        "typeTamer",
        "blendBoss",
        "mockMaster"
      ][i % 30],
      "name": [ // Changed "realName" to "name" to match your previous format
        "Priya Bisht",
        "Arjun Mehta",
        "Riya Malhotra",
        "Kunal Shah",
        "Nisha Verma",
        "Aman Tiwari",
        "Priya Sinha",
        "Devanshi Patel",
        "Rajiv Menon",
        "Ishaan Roy",
        "Simran Kaur",
        "Sneha Iyer",
        "Raghav Kapoor",
        "Meera Nandan",
        "Tanmay Joshi",
        "Kritika Arora",
        "Ankit Rawal",
        "Suman S",
        "Pranav D",
        "Lakshmi G",
        "Shubham V",
        "Divya B",
        "Mukesh S",
        "Isha N",
        "Namrata P",
        "Aakash R",
        "Mona L",
        "Deepak M",
        "Aarti S",
        "Neha J"
      ][i % 30]
    },
  );

  final List<Map<String, String>> following = List.generate(
    30,
        (i) => {
      "avatar": "https://i.pravatar.cc/150?img=${(55 - (i % 40))}",
      "username": [
        "mockupNomad",
        "uiAlchemy",
        "wireframeWhiz",
        "devDynamo",
        "uxZenith",
        "snappyGrids",
        "neonMockups",
        "swipeSavvy",
        "protoPilot",
        "themeThrive",
        "layerLover",
        "iconicIdeas",
        "layoutLex",
        "colorCraze",
        "stackSynergy",
        "vectorVision",
        "gridGuru",
        "shadeShift",
        "typeTamer",
        "blendBoss",
        "mockMaster",
        "alex.mason",
        "pixelVoyager",
        "codeNectar",
        "DesignDruid",
        "aestheticLoop",
        "byteCrush",
        "craftMuse",
        "tintTheory",
        "buildBard",
        "snapSculpt"
      ][i % 30],
      "name": [ // Changed "realName" to "name" to match your original format
        "Ishaan Roy",
        "Simran Kaur",
        "Sneha Iyer",
        "Raghav Kapoor",
        "Meera Nandan",
        "Tanmay Joshi",
        "Kritika Arora",
        "Ankit Rawal",
        "Suman S",
        "Pranav D",
        "Lakshmi G",
        "Shubham V",
        "Divya B",
        "Mukesh S",
        "Isha N",
        "Namrata P",
        "Aakash R",
        "Mona L",
        "Deepak M",
        "Aarti S",
        "Neha J",
        "Priya Bisht",
        "Arjun Mehta",
        "Riya Malhotra",
        "Kunal Shah",
        "Nisha Verma",
        "Aman Tiwari",
        "Priya Sinha",
        "Devanshi Patel",
        "Rajiv Menon",
        "Sonam K"
      ][i % 30]
    },
  );
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text("jacob_w", style: TextStyle(color: Colors.white)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsCenterPage()));
            },
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          // Top Profile Info & Stats
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Followers Stat
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FollowersListScreen(followers: followers),
                      ),
                    );
                  },
                  child: _buildStat("260k", "Followers"),
                ),
                // Profile Image
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  NetworkImage('https://i.pravatar.cc/150?img=3'),
                ),
                // Following Stat
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FollowingListScreen(following: following),
                      ),
                    );
                  },
                  child: _buildStat("326", "Following"),
                ),
              ],
            ),
          ),
          // Name & Bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  "Jack Stone | Freelancer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  "Digital goodies designer @pixsellz\nEverything is designed.",
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    // Implement URL launch logic if desired
                  },
                  child: Text(
                    "https://youtu.be/7mr1uF4DZFos",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          // Edit Profile Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 36),
              ),
              child: Text("Edit Profile"),
            ),
          ),
          // New Post Button
          Column(
            children: [
              Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
              SizedBox(height: 4),
              Text("New Post", style: TextStyle(color: Colors.white)),
              SizedBox(height: 12),
            ],
          ),
          // Tabs (Grid/Video)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.grid_on, color: Colors.white),
              SizedBox(width: 30),
              Icon(Icons.video_collection_outlined, color: Colors.white),
            ],
          ),
          SizedBox(height: 12),
          // Grid Images
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(1),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Image.network(
                  "https://picsum.photos/id/${index + 10}/200/200",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
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
