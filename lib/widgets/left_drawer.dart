import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:uas/main.dart';
import 'package:uas/screens/authentication/login.dart';
import 'package:uas/screens/bookmark/bookmark_list.dart';
import 'package:uas/screens/landing.dart';
import 'package:uas/screens/news/main_berita.dart';
import 'package:uas/screens/profile/profile.dart';
import 'package:uas/screens/thread/thread.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final isLoggedIn = request.loggedIn;
    final role = isLoggedIn ? request.getJsonData()['data']['role'] : null;

    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Column(
            children: [
              Text(
                'Mangan" Solo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Text(
                "Makan lezat, yuk!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        // Simplified Login/Profile logic
        ListTile(
          leading: const Icon(
            Icons.person_3_rounded,
            color: Colors.black87,
          ),
          title: Text(
            isLoggedIn ? 'Profile' : 'Login',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    isLoggedIn ? const ProfilePage() : const LoginPage(),
              ),
            );
          },
        ),
        // Halaman Utama link
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Halaman Utama'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
        // Thread link
        ListTile(
          leading: const Icon(IconData(0xf0541, fontFamily: 'MaterialIcons')),
          title: const Text('Thread'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThreadScreen(),
              ),
            );
          },
        ),
        // Berita/Ulasan based on role
        if (isLoggedIn && role == 'RESTO_OWNER')
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
            ),
            title: const Text('Berita'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainBeritaScreen(),
                ),
              );
            },
          ),
        // Bookmark link for Customer role
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.bookmark_add_outlined),
            title: const Text('Bookmark'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarkListScreen(),
                ),
              );
            },
          ),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.door_back_door_outlined),
            title: const Text('Logout'),
            onTap: () async {
              final res =
                  await request.logout('${CONSTANTS.baseUrl}/auth/flogout/');

              if (res['success']) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
          ),
      ],
    ));
  }
}
