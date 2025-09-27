import 'package:flutter/material.dart';



// ---------------- Account Entity Page ----------------

class AccountEntityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, 'Account Entity'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _entityTile(icon: Icons.assignment_outlined, text: "Personal details", onTap: () {}),
              _divider(),
              _entityTile(icon: Icons.verified_user_outlined, text: "Password and security", onTap: () {}),
              _divider(),
              _entityTile(icon: Icons.home_work_outlined, text: "Login activity", onTap: () {}),
            ],
          ),
        ),
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
  Widget _divider() =>
      Divider(color: Colors.grey[800], thickness: 1, indent: 12, endIndent: 12);

  Widget _entityTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      minLeadingWidth: 28,
      horizontalTitleGap: 6,
    );
  }
}

// ---------------- Account Privacy Page ----------------

class AccountPrivacyPage extends StatefulWidget {
  @override
  State<AccountPrivacyPage> createState() => _AccountPrivacyPageState();
}

class _AccountPrivacyPageState extends State<AccountPrivacyPage> {
  bool privateAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, 'Account Privacy'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Private Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Spacer(),
                Switch(
                  value: privateAccount,
                  onChanged: (value) => setState(() => privateAccount = value),
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[700],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "• When your account is public, anyone can view your profile and posts, on or off Instalearn.\n\n• When your account is private, only followers you approve can see your posts and profile.",
              style: TextStyle(color: Colors.grey[300], fontSize: 15),
            ),
          ],
        ),
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
}

// ---------------- Notification Page ----------------

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool userNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, 'Notification'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('User Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Spacer(),
                Switch(
                  value: userNotification,
                  onChanged: (value) => setState(() => userNotification = value),
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[700],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "• When notifications are enabled, you’ll get alerts when someone likes, comments, or messages you.\n\n• When notifications are disabled, you won’t get alerts when someone likes, comments, or messages you.",
              style: TextStyle(color: Colors.grey[300], fontSize: 15),
            ),
          ],
        ),
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

}