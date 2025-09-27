import 'package:flutter/material.dart';
import 'package:instagram_app/views/sub_settings_screen.dart';

class SettingsCenterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, 'Settings Center'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _searchBar(),
          _listTile(
            context,
            icon: Icons.account_circle_outlined,
            title: 'Account Entity',
            subtitle: 'Password, Security, Personal Details',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AccountEntityPage()),
            ),
          ),
          _listTile(
            context,
            icon: Icons.security_outlined,
            title: 'Account Privacy',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AccountPrivacyPage()),
            ),
          ),
          _sectionHeader('Preferences'),
          _listTile(
            context,
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationPage()),
            ),
          ),
          _listTile(
            context,
            icon: Icons.block,
            title: 'Restricted',
            onTap: () {}, // Add navigation if needed
          ),
          _listTile(
            context,
            icon: Icons.bookmark_border,
            title: 'Saved',
            onTap: () {}, // Add navigation if needed
          ),
          _sectionHeader('Resources'),
          _listTile(context, icon: Icons.help_outline, title: 'Contact Support', trailing: true, onTap: () {}),
          _listTile(context, icon: Icons.star_border, title: 'Rate us', trailing: true, onTap: () {}),
          _listTile(context, icon: Icons.person_outline, title: 'Help', trailing: true, onTap: () {}),
          _listTile(context, icon: Icons.policy, title: 'Terms & Privacy', trailing: true, onTap: () {}),
          _listTile(context, icon: Icons.question_mark, title: 'FAQ\'s', trailing: true, onTap: () {}),
          Divider(color: Colors.grey.shade800, thickness: 1, height: 32),
          _listTile(context, icon: Icons.info_outline, title: 'About Instalearn', onTap: () {}),
        ],
      ),
    );
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

  Widget _searchBar() => Container(
    margin: EdgeInsets.only(bottom: 16, top: 4),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );

  Widget _listTile(BuildContext context, {required IconData icon, required String title, String? subtitle, bool trailing = false, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500)) : null,
      trailing: trailing
          ? Icon(Icons.open_in_new, color: Colors.white, size: 21)
          : Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      onTap: onTap,
      minLeadingWidth: 28,
      horizontalTitleGap: 6,
    );
  }

  Widget _sectionHeader(String text) => Padding(
    padding: EdgeInsets.only(top: 24, bottom: 10, left: 3),
    child: Text(text, style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 15)),
  );
}