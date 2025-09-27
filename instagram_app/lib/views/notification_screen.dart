import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Reel from @john_doe',
      'subtitle': 'Check out the latest reel on travel adventures!',
      'time': '2 mins ago'
    },
    {
      'title': 'Your reel is trending!',
      'subtitle': 'Congrats! Your reel has 10K views.',
      'time': '10 mins ago'
    },
    {
      'title': '@jane_smith liked your reel',
      'subtitle': 'She commented: Amazing shots!',
      'time': '1 hour ago'
    },
    {
      'title': 'New follower: @adventure_lover',
      'subtitle': 'They started following you.',
      'time': '3 hours ago'
    }
  ];

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _appBar(context, 'Notifications'),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.redAccent),
            title: Text(notification['title']!),
            subtitle: Text(notification['subtitle']!),
            trailing: Text(
              notification['time']!,
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
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

