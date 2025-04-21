import 'package:flutter/material.dart';
class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orangeAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              // Profile Section
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      NetworkImage("https://via.placeholder.com/150"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hello, Aditi",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "aditi123@gmail.com",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              // Drawer Menu Items
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      drawerItem(Icons.edit, "Edit Profile", () {}),
                      drawerItem(Icons.history, "My History", () {}),
                      drawerItem(Icons.settings, "Settings", () {}),
                      drawerItem(Icons.logout, "Log Out", () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}