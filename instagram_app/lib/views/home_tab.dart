import 'package:flutter/material.dart';
import 'package:instagram_app/viewmodels/auth_view_model.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'message_screen.dart';
import 'notification_screen.dart';

class HomeTab extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<HomeTab> {
  List<VideoPlayerController> controllers = [];
  PageController _pageController = PageController();
  bool _isLoading = true;

  final List<String> videoPaths = [
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
    "assets/video/test2.mp4",
  ];
  bool isBookmarked = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeAssetVideos();
  }

  Future<void> _initializeAssetVideos() async {
    print("Initializing local video controllers...");
    controllers = videoPaths
        .map((path) => VideoPlayerController.asset(path)..initialize())
        .toList();

    controllers.first.play();

    setState(() {
      _isLoading = false;
    });

    _pageController.addListener(() {
      int currentPage = _pageController.page!.round();
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
    var controller = controllers[index];
    isDarkMode = true;
    return Column(
      children: [
        // Video player with vertical action buttons
        Expanded(
          child: Stack(
            children: [
              // Video playback
              Positioned.fill(
                child: controller.value.isInitialized
                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                )
                    : const Center(child: CircularProgressIndicator()),
              ),

              // Vertical buttons on the right side
              Positioned(
                right: 10,
                bottom: 30,
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

        // Bottom info section (Not overlay)
        Container(
          width: double.infinity,
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with avatar, name, and more icon
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Kelly Vishwas',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () => showActionSheet(context, userName: 'Lshivam', isDarkMode: true),
                  )

                ],
              ),
              const SizedBox(height: 8),

              // Caption text
              Text(
                'The game in Japan was amazing and I want to share some photos',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),

              // Liked by text
              Text(
                'Liked by craig_love and 44,686 others',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
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


  // Widget _buildVideoCard(int index, bool isDarkMode) {
  //   var controller = controllers[index];
  //
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: Stack(
  //           children: [
  //             Positioned.fill(
  //               child: controller.value.isInitialized
  //                   ? GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     if (controller.value.isPlaying) {
  //                       controller.pause();
  //                     } else {
  //                       controller.play();
  //                     }
  //                   });
  //                 },
  //                 child: AspectRatio(
  //                   aspectRatio: controller.value.aspectRatio,
  //                   child: VideoPlayer(controller),
  //                 ),
  //               )
  //                   : const Center(child: CircularProgressIndicator()),
  //             ),
  //             Positioned(
  //               top: 10,
  //               left: 15,
  //               right: 15,
  //               child: Row(
  //                 children: [
  //                   const CircleAvatar(
  //                     radius: 20,
  //                     backgroundImage:
  //                     NetworkImage("https://i.pravatar.cc/300"),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Text(
  //                     'Local Video',
  //                     style: TextStyle(
  //                         color: isDarkMode ? Colors.white : Colors.black,
  //                         fontSize: 16),
  //                   ),
  //                   const Spacer(),
  //                   Icon(Icons.more_vert,
  //                       color: isDarkMode ? Colors.white : Colors.black),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Container(
  //         height: 60,
  //         color: isDarkMode ? Colors.black : Colors.white,
  //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(Icons.favorite_border,
  //                     color: isDarkMode ? Colors.white : Colors.black,
  //                     size: 28),
  //                 const SizedBox(width: 15),
  //                 Icon(Icons.comment_outlined,
  //                     color: isDarkMode ? Colors.white : Colors.black,
  //                     size: 28),
  //               ],
  //             ),
  //             Icon(Icons.bookmark_border,
  //                 color: isDarkMode ? Colors.white : Colors.black, size: 28),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }


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
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videoPaths.length,
              itemBuilder: (context, index) {
                return _buildVideoCard(index, isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }
}

//
// class _VideoFeedScreenState extends State<HomeTab> {
//   List<VideoPlayerController> controllers = [];
//   PageController _pageController = PageController();
//   bool _isLoading = true;
//
//   final List<String> videoPaths = [
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//   ];
//   @override
//   void initState() {
//     super.initState();
//
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   _fetchVideos();
//     // });
//
//     _initializeAssetVideos();
//   }
//   Future<void> _initializeAssetVideos() async {
//     print("Initializing local video controllers...");
//     controllers = videoPaths
//         .map((path) => VideoPlayerController.asset(path)..initialize())
//         .toList();
//
//     controllers.first.play();
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     _pageController.addListener(() {
//       int currentPage = _pageController.page!.round();
//       for (int i = 0; i < controllers.length; i++) {
//         if (i == currentPage) {
//           controllers[i].play();
//         } else {
//           controllers[i].pause();
//         }
//       }
//     });
//   }
//
//   Future<void> _fetchVideos() async {
//     print("Fetching videos...");
//     final provider = Provider.of<AuthViewModel>(context, listen: false);
//     await provider.getVideos();
//
//     if (provider.videos.isNotEmpty) {
//       print("Initializing video controllers...");
//       controllers = provider.videos
//           .map((video) {
//         print("Initializing: ${video.s3Url}");
//         return VideoPlayerController.network(video.s3Url)..initialize();
//       })
//           .toList();
//       // controllers = await Future.wait(
//       //   provider.videos.map((video) async {
//       //     var controller = VideoPlayerController.network(video.s3Url);
//       //     await controller.initialize();
//       //     return controller;
//       //   }).toList(),
//       // );
//
//       controllers.first.play();
//     } else {
//       print("No videos available.");
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     _pageController.addListener(() {
//       int currentPage = _pageController.page!.round();
//       for (int i = 0; i < controllers.length; i++) {
//         if (i == currentPage) {
//           controllers[i].play();
//         } else {
//           controllers[i].pause();
//         }
//       }
//     });
//   }
//
//
//
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   Widget _buildVideoCard(int index, bool isDarkMode) {
//     final provider = Provider.of<AuthViewModel>(context);
//     final videos = provider.videos;
//
//     if (videos.isEmpty) {
//       print("No videos in provider.");
//      // return Center(child: Text("No videos available"));
//     }
//
//     var controller = controllers[index];
//
//     print("Building video card for index: $index");
//
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: controller.value.isInitialized
//                     ? VideoPlayer(controller)
//                     : Center(child: CircularProgressIndicator()),
//               ),
//               Positioned(
//                 top: 10,
//                 left: 15,
//                 right: 15,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       videos[index].title,
//                       style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 16),
//                     ),
//                     Spacer(),
//                     Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 60,
//           color: isDarkMode ? Colors.black : Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.favorite_border, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//                   SizedBox(width: 15),
//                   Icon(Icons.comment_outlined, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//                 ],
//               ),
//               Icon(Icons.bookmark_border, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final provider = Provider.of<AuthViewModel>(context);
//
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: colorScheme.surface,
//         title: Text(
//           'KnowReel',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: colorScheme.onSurface,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications, color: colorScheme.onSurface),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (_) => NotificationsScreen()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.message, color: colorScheme.onSurface),
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (_) => MessagesScreen()));
//             },
//           ),
//         ],
//       ),
//       backgroundColor: isDarkMode ? Colors.black : Colors.white,
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : provider.videos.isEmpty
//           ? Center(child: Text("No videos found"))
//           : Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.vertical,
//               itemCount: provider.videos.length,
//               itemBuilder: (context, index) {
//                 return _buildVideoCard(index, isDarkMode);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



//
// class HomeTab extends StatefulWidget {
//   @override
//   _VideoFeedScreenState createState() => _VideoFeedScreenState();
// }

// class _VideoFeedScreenState extends State<HomeTab> {
//   final List<String> videoPaths = [
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//     "assets/video/test2.mp4",
//     // Add more video files if available
//   ];
//
//   final List<VideoPlayerController> controllers = [];
//   PageController _pageController = PageController();
//
//   @override
//   void initState() {
//     super.initState();
//     for (var path in videoPaths) {
//       controllers.add(VideoPlayerController.asset(path)..initialize());
//     }
//
//     // Play the first video initially
//     controllers.first.play();
//
//     _pageController.addListener(() {
//       int currentPage = _pageController.page!.round();
//       for (int i = 0; i < controllers.length; i++) {
//         if (i == currentPage) {
//           controllers[i].play();
//         } else {
//           controllers[i].pause();
//         }
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     _pageController.dispose();
//     super.dispose();
//   }
//   Widget _buildVideoCard(int index, bool isDarkMode) {
//     // Detect Dark or Light Mode
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Column(
//       children: [
//         // **Video Container (Expands to Fit Available Space)**
//         Expanded(
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: controllers[index].value.isInitialized
//                     ? VideoPlayer(controllers[index])
//                     : Center(child: CircularProgressIndicator()),
//               ),
//               // Profile & More Options
//               Positioned(
//                 top: 10,
//                 left: 15,
//                 right: 15,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
//                     ),
//                     SizedBox(width: 10),
//                     Text("username", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 16)),
//                     Spacer(),
//                     Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // **Fixed Bottom Action Bar (Like, Comment, Share)**
//         Container(
//           height: 60, // Fixed height to prevent overflow
//           color: isDarkMode ? Colors.black : Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.favorite_border, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//                   SizedBox(width: 15),
//                   Icon(Icons.comment_outlined, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//                   //SizedBox(width: 15),
//                   //Icon(Icons.send, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//                 ],
//               ),
//               Icon(Icons.bookmark_border, color: isDarkMode ? Colors.white : Colors.black, size: 28),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Detect Dark or Light Mode
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDarkMode ? Colors.black : Colors.white,
//       body: Column(
//         children: [
//           // **Fixed Header**
//           // Container(
//           //   height: 60, // Fixed header height
//           //   color: isDarkMode ? Colors.black : Colors.white,
//           //   padding: EdgeInsets.symmetric(horizontal: 15),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text(
//           //         "Instagram",
//           //         style: TextStyle(
//           //           fontSize: 22,
//           //           fontWeight: FontWeight.bold,
//           //           color: isDarkMode ? Colors.white : Colors.black,
//           //         ),
//           //       ),
//           //       Row(
//           //         children: [
//           //           Icon(Icons.favorite_border, size: 28, color: isDarkMode ? Colors.white : Colors.black),
//           //           SizedBox(width: 20),
//           //           Icon(Icons.chat_bubble_outline, size: 28, color: isDarkMode ? Colors.white : Colors.black),
//           //         ],
//           //       ),
//           //     ],
//           //   ),
//           // ),
//
//           // **Scrollable Video Feed (Takes Remaining Space)**
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.vertical,
//               itemCount: videoPaths.length,
//               itemBuilder: (context, index) {
//                 return _buildVideoCard(index, isDarkMode);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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