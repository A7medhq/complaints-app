import 'package:complaints/views/auth.dart';
import 'package:complaints/views/home.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static const id = '/mainLayout';

  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  DrawerSections currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    Widget? body;
    String title = '';

    if (currentPage == DrawerSections.home) {
      body = const HomeScreen();
      title = 'home';
    } else if (currentPage == DrawerSections.auth) {
      body = const AuthScreen();
      title = 'auth';
    }
    return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [myDrawerList()],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {},
                child: const Material(
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 3)),
                  child: CircleAvatar(
                    backgroundColor: Color(0xff3A98B9),
                  ),
                ),
              ),
            )
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: body);
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(
            id: 0,
            title: 'Dashboard',
            icon: Icons.dashboard_rounded,
            selected: currentPage == DrawerSections.home ? true : false,
          ),
          menuItem(
            id: 1,
            title: 'Check In/Out',
            icon: Icons.dashboard_rounded,
            selected: currentPage == DrawerSections.auth ? true : false,
          ),
          menuItem(
            id: -1,
            title: 'Logout',
            icon: Icons.dashboard_rounded,
            selected: currentPage == DrawerSections.logout ? true : false,
          ),
        ],
      ),
    );
  }

  Widget menuItem(
      {required IconData icon,
      required String title,
      required int id,
      required bool selected}) {
    return Material(
      color: selected ? Colors.grey.shade300 : Colors.transparent,
      child: InkWell(
        onTap: () async {
          Navigator.pop(context);
          setState(() {
            if (id == 0) {
              currentPage = DrawerSections.home;
            } else if (id == 1) {
              currentPage = DrawerSections.auth;
            } else if (id == -1) {}
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { home, auth, logout }
