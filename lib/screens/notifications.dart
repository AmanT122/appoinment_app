import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Message",
      description: "You have received a new message from John.",
      time: "2 min ago",
      icon: Icons.message,
    ),
    NotificationItem(
      title: "Update Available",
      description: "A new update is available for your app.",
      time: "10 min ago",
      icon: Icons.system_update,
    ),
    NotificationItem(
      title: "Reminder",
      description: "Don't forget your meeting at 3 PM today.",
      time: "1 hr ago",
      icon: Icons.notifications_active,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(notification.icon, color: Colors.blue),
            title: Text(notification.title),
            subtitle: Text(notification.description),
            trailing: Text(
              notification.time,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Add action when tapped (optional)
            },
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });
}
