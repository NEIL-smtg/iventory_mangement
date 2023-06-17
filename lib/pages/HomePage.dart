import 'dart:js';

import 'package:flutter/material.dart';
import 'package:inventory_management/constant/constants.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';
import 'package:inventory_management/chart/chartHomePage.dart';
import 'package:inventory_management/pages/report/reportPage.dart';
import 'package:flutter/src/widgets/framework.dart';


// const Color bgColor = Color(0xFF4A4A58);
const Color bgColor = Colors.white;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  bool isCollapsed = true;
  double screenWidth = 0, screenHeight = 0;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    screenHeight = size.height;

    return realDesign(context);
  }

  Scaffold realDesign(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NavMenu(pageNum: 0),
          ],
        ),
      ),
    );
  }


  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : 0.02 * screenHeight,
      bottom: isCollapsed ? 0 : 0.02 * screenWidth,
      left: isCollapsed ? 0 : 200,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        color: bgColor,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            children: [
              Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: const Icon(Icons.menu, color: Colors.black),
                        onTap: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const Icon(Icons.settings, color: Colors.black),
                    ],
                  ),
                ),
              ),
              scrollingContainer(),
              alertsBox(context),
            ],
          ),
        ),
      ),
    );
  }
}

Expanded scrollingContainer()
{
   return Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              miniDashboard(context),
              const SizedBox(height: 50),
              Chart(),
            ]
          )
        )
   );
}

Widget alertsBox(BuildContext context) { // Add the context parameter
  const alertCount = 10;
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => reportPage()), // Replace with the page you want to navigate to
      );
    },
    child: Material(
      color: bgColor,
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 10),
            ),
            Text(
              'Alerts',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '$alertCount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget miniDashboard(context)
{
  Constants constant = const Constants();

  return Material(
    color: bgColor,
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          buildOverflowText('Total Revenue : ${constant.getTotalRevenue()}'),
          const Text('|'),
          buildOverflowText('Cash Available : ${constant.getCashAvailable()}'),
          const Text('|'),
          buildOverflowText('Items in Stock : ${constant.getItemsInStock()}'),
          const Text('|'),
          buildOverflowText('Monthly Sale (current): ${constant.getMonthlySale()}'),
          const Text('|'),
          buildOverflowText('Monthly Sale (average): ${constant.getMonthlySaleAvg()}'),
          const Text('|'),
        ],
      ),
    ),
  );
}

Widget buildOverflowText(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 15,
        ),
      ),
    ],
  );
}

/*
1. pagination
2. data table
3. restful api
4. update storage page
*/