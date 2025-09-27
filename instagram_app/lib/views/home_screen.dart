import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/views/post_screen.dart';
import 'home_tab.dart';
import 'message_screen.dart';
import 'notification_screen.dart';
import 'search_tab.dart';
import 'upload_tab.dart';
import 'reels_tab.dart';
import 'profile_tab.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PostListScreen(),
    SearchTab(),
    ReelsTab(), // Using "ReelsTab" as the favorites/heart tab
    ProfileTab(),
  ];

  final List<String> _navImages = [
    'assets/images/nav_home_selected.png',
    'assets/images/nav_search_selected.png',
    'assets/images/nav_fav_selected.png',
    'assets/images/nav_profile_selected.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: GestureDetector(
        onTapUp: (TapUpDetails details) {
          final width = MediaQuery.of(context).size.width;
          final dx = details.localPosition.dx;
          final tappedIndex = (dx / (width / 4)).floor();
          _onItemTapped(tappedIndex);
        },
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Image.asset(
            _navImages[_selectedIndex],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _pages = [
//     HomeTab(),
//     SearchTab(),
//     //UploadTab(),
//     ReelsTab(),
//     ProfileTab(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     var colorScheme = theme.colorScheme;
//
//     return Scaffold(
//       //backgroundColor: colorScheme.background,
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
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsScreen()),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.message, color: colorScheme.onSurface),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MessagesScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: colorScheme.surface,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: colorScheme.onSurface,
//         unselectedItemColor: colorScheme.onSurface.withOpacity(0.5),
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           _buildNavItem('assets/svg/home_filled.svg', 0),
//           _buildNavItem('assets/svg/search.svg', 1),
//           //_buildNavItem('assets/svg/add_post.svg', 2),
//           _buildNavItem('assets/svg/reels.svg', 3),
//           _buildNavItem('assets/svg/profile.svg', 4),
//         ],
//       ),
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem(String asset, int index) {
//     var theme = Theme.of(context);
//     var colorScheme = theme.colorScheme;
//     return BottomNavigationBarItem(
//       icon: SvgPicture.asset(
//         asset,
//         color: _selectedIndex == index ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.5),
//         height: 24,
//       ),
//       label: '',
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'KnowReel',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle notification action
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.message),
//             onPressed: () {
//               // Handle message action
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Container()
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         showSelectedLabels: false,
//         showUnselectedLabels: false, // Hides labels
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.video_collection), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//     );
//   }
// }
