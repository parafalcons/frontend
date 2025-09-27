import 'package:flutter/material.dart';

// class MessagesScreen extends StatelessWidget {
//   const MessagesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     var colorScheme = theme.colorScheme;
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//               'Messages', style: TextStyle(color: colorScheme.onSurface)),
//           backgroundColor: colorScheme.surface,
//           iconTheme: IconThemeData(color: colorScheme.onSurface),
//         ),
//         body: Center(child: Text('Messages Screen')));
//   }
// }
class User {
  final String name;
  final String username;
  final String avatarUrl;
  final int followers;
  final int posts;
  User(this.name, this.username, this.avatarUrl, this.followers, this.posts);
}

List<User> users = List.generate(
  10,
      (index) => User(
    ['Snehal Iyer', 'Joseph Ay', 'Rohan Ban', 'Classy Saxena', 'Jason Ponsa',
      'Vishwas Ray', 'Swati Tiwari', 'Ridhima Jha', 'Nandani Bhattacharya', 'User $index'][index % 10],
    'user$index',
    'https://i.pravatar.cc/150?img=${index + 1}',
    1000 + 40 * index,
    10 + index,
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging Suggestions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _appBar(context, 'Jacob_w'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              // Search Pill
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.white70),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // helper text
              const Text(
                "Chats will appear here after you've sent or received a message.",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 20),
              const Text(
                'Suggestions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // list of suggestions
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 28),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (context, i) {
                    final user = users[i];
                    return _SuggestionRow(user: user, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatProfileScreen(user: user),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          fontSize: 20,
        ),
      ),
      leading: Navigator.canPop(context)
          ? const BackButton(color: Colors.white)
          : IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Center(
            child: Text(
              'Requests',
              style: TextStyle(color: colorScheme.onSurface, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  const _SuggestionRow({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Layout tuned to match screenshot spacing
    return Row(
      children: [
        // avatar square with rounded corners
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            user.avatarUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 56,
              height: 56,
              color: Colors.grey[800],
              child: const Icon(Icons.person, color: Colors.white70),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // name (big)
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 8),
        // outlined rounded button similar to image
        OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Message',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}



class ChatProfileScreen extends StatefulWidget {
  final User user;
  ChatProfileScreen({required this.user});

  @override
  _ChatProfileScreenState createState() => _ChatProfileScreenState();
}

class _ChatProfileScreenState extends State<ChatProfileScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 285,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage:
                      NetworkImage(widget.user.avatarUrl),
                    ),
                    SizedBox(height: 18),
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.user.username,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.03),
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.white24, width: 1),
                        ),
                        child: Text(
                          "View profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: _messages.isEmpty
                      ? Container()
                      : ListView.builder(
                    padding:
                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _messages[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 22),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Message....',
                            hintStyle:
                            TextStyle(color: Colors.grey[600]),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 18),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            String text = _controller.text.trim();
                            if (text.isNotEmpty) {
                              setState(() {
                                _messages.add(text);
                              });
                              _controller.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
