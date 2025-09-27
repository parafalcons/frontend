import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';


class ReelsTab extends StatefulWidget {
  const ReelsTab({super.key});


  @override
  State<ReelsTab> createState() => _AssetReelsViewState();
}

class _AssetReelsViewState extends State<ReelsTab> {

  final List<String> videoPaths = [
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
  ];
  late final List<VideoPlayerController> controllers;
  late final PageController _pageController;
  bool _isLoading = true;

  bool isBookmarked = false;
  bool isFavorite = false;


  @override
  void initState() {
    super.initState();
    controllers = [];
    _pageController = PageController();
    _initializeAssetVideos();
  }

  Future<void> _initializeAssetVideos() async {
    // Initialize and pre-buffer all controllers
    for (final path in videoPaths) {
      final controller = VideoPlayerController.asset(path);
      controllers.add(controller);
      await controller.initialize();
    }
    controllers[0].play();
    setState(() { _isLoading = false; });

    // Handle play/pause on vertical swipe
    _pageController.addListener(() {
      final int currentPage = _pageController.page?.round() ?? 0;
      for (int i = 0; i < controllers.length; i++) {
        if (i == currentPage) {
          controllers[i].play();
        } else {
          controllers[i].pause();
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildVideoCard(int index, bool isDarkMode) {
    final controller = controllers[index];
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Video
              Positioned.fill(
                child: controller.value.isInitialized
                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (controller.value.isPlaying)
                        controller.pause();
                      else
                        controller.play();
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                )
                    : const Center(child: CircularProgressIndicator()),
              ),
              // Action Buttons
              Positioned(
                right: 16,
                bottom: 36,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: isBookmarked
                          ? const Icon(Icons.bookmark, color: Colors.white, size: 32)
                          : const Icon(Icons.bookmark_border, color: Colors.white, size: 32),
                      onPressed: () {
                        setState(() => isBookmarked = !isBookmarked);
                      },
                    ),
                    SizedBox(height: 22),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white, size: 32),
                      onPressed: () {
                        Share.share('Check out this amazing reel on our app!');
                      },
                    ),
                    SizedBox(height: 22),
                    IconButton(
                      icon: Icon(Icons.comment_outlined, color: Colors.white, size: 32),
                      onPressed: () => showCommentsSheet(context),
                    ),
                    SizedBox(height: 22),
                    IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red, size: 32)
                          : const Icon(Icons.favorite_border, color: Colors.white, size: 32),
                      onPressed: () {
                        setState(() => isFavorite = !isFavorite);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom Info
        Container(
          width: double.infinity,
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Demo User',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () => showActionSheet(context, userName: 'Lshivam', isDarkMode: true),
                  )

                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Sample local assets reel video.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Liked by demo_user and 390 others',
                style: TextStyle(
                  color: isDarkMode ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: videoPaths.length,
      itemBuilder: (context, index) =>
          _buildVideoCard(index, isDarkMode),
    );
  }
  void showActionSheet(BuildContext context, {required String userName, required bool isDarkMode}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Actions Row (Save & Message)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionCard(
                      icon: Icons.bookmark_border,
                      label: 'Save',
                      isDarkMode: isDarkMode,
                      onTap: () {/* Save action */},
                    ),
                    _ActionCard(
                      icon: Icons.send,
                      label: 'Message',
                      isDarkMode: isDarkMode,
                      onTap: () {/* Message action */},
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // "Unfollow" and "Report" group
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_remove, color: isDarkMode ? Colors.white : Colors.black),
                        title: Text('Unfollow',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {/* Unfollow action */},
                      ),
                      Divider(height: 1, color: isDarkMode ? Colors.grey[800] : Colors.grey[300]),
                      ListTile(
                        leading: Icon(Icons.error_outline, color: Colors.red),
                        title: Text('Report $userName',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {/* Report action */},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

// Call this in your video card where you handle comment icon tap
  void showCommentsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: DraggableScrollableSheet(
            initialChildSize: 0.56,
            minChildSize: 0.36,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 6,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Comments',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: Icon(Icons.person, color: Colors.white60),
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'alex.mason ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'The best video guide i have found till now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text('Reply', style: TextStyle(color: Colors.white60, fontSize: 12)),
                                SizedBox(width: 16),
                                Text('View 3 more replies', style: TextStyle(color: Colors.white60, fontSize: 12)),
                              ],
                            ),
                            trailing: Icon(Icons.favorite_border, color: Colors.white, size: 22),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          Divider(color: Colors.white10),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("https://i.pravatar.cc/301"),
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'sassy__johnathan ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'The game in Japan was amazing and I want to share some photos.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("https://i.pravatar.cc/302"),
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'sassy__johnathan ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'The game in Japan was amazing and I want to share some photos.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _emojiIcon('❤️'),
                          _emojiIcon('😍'),
                          _emojiIcon('😳'),
                          _emojiIcon('😂'),
                          _emojiIcon('😜'),
                          _emojiIcon('💖'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 14),
                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder( // Use OutlineInputBorder for a visible border
                              borderRadius: BorderRadius.circular(22), // Match the container's border radius
                              borderSide: BorderSide.none, // You can make the border invisible if you only want the container's visual
                            ),
                            enabledBorder: OutlineInputBorder( // Border when the TextField is enabled but not focused
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: Colors.white54, width: 1.0), // Example: a subtle white border
                            ),
                            focusedBorder: OutlineInputBorder( // Border when the TextField is focused
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: Colors.white, width: 2.0), // Example: a more prominent white border
                            ),
                            hintText: 'Share your thoughts on this...',
                            hintStyle: TextStyle(color: Colors.white38),
                            // If you want to remove the default padding inside the TextField when it has a border:
                            //contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _emojiIcon(String emoji) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(emoji, style: TextStyle(fontSize: 26)),
      ),
    );
  }


}
// Modular Action Card Widget
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;
  final VoidCallback onTap;
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.isDarkMode,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (isDarkMode ? Colors.black54 : Colors.grey[300]!).withOpacity(0.12),
                blurRadius: 10, offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 27, color: isDarkMode ? Colors.white : Colors.black54),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              )),
            ],
          ),
        ),
      ),
    );
  }
}