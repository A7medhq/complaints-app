import 'package:complaints/components/drawer/custom_drawer_header.dart';
import 'package:complaints/services/auth_services.dart';
import 'package:complaints/views/home.dart';
import 'package:complaints/views/loading.dart';
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

    if (currentPage == DrawerSections.home) {
      body = const HomeScreen();
    }

    return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomHeaderDrawer(),
                CustomDrawerList(
                  children: [
                    menuItem(
                      id: 0,
                      title: 'Home',
                      icon: Icons.home_outlined,
                      selected:
                          currentPage == DrawerSections.home ? true : false,
                    ),
                    menuItem(
                      id: -1,
                      title: 'Logout',
                      icon: Icons.logout_outlined,
                      selected:
                          currentPage == DrawerSections.logout ? true : false,
                    ),
                  ],
                )
              ],
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
            } else if (id == -1) {
              AuthServices.logout().then((value) {
                if (value) {
                  Navigator.pushReplacementNamed(context, LoadingScreen.id);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Unable to logout')));
                }
              });
            }
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

class CustomDrawerList extends StatelessWidget {
  final List<Widget> children;

  const CustomDrawerList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: children,
      ),
    );
  }
}

enum DrawerSections { home, logout }
