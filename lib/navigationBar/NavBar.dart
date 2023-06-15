import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/CompanyName.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavBar>{

  @override
  Widget build(BuildContext context) {
  
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff333951),
      child: Stack(
        children: [
          CompanyName(),
          const Align(
            alignment: Alignment.center,
            child: NavMenu(pageNum: 0),
          ),
        ],
      ),
      )
    );
  }
}
