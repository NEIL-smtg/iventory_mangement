import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:inventory_management/pages/homePage.dart';
import 'package:inventory_management/pages/report/reportPage.dart';
import 'package:inventory_management/pages/inventory/inventoryPage.dart';
import 'package:inventory_management/pages/alerts/alertsPage.dart';

class NavMenu extends StatefulWidget {
  final int pageNum;

  const NavMenu({Key? key, required this.pageNum}) : super(key: key);

  @override
  _NavMenuState createState() => _NavMenuState();
  
}

class _NavMenuState extends State<NavMenu>{
  int pageNum = 0;
  List<bool> selected = [false, false, false, false, false];

  @override
  void initState() {
    pageNum = widget.pageNum;
    selected[pageNum] = true;
    super.initState();
  }

  void  select(int n){
    for (var i = 0; i < selected.length; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
        if (i != pageNum){
          switch (i) {
            case 0:
              Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
            break;
            case 1:
               Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => reportPage()));
            break;
            case 2:
              Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => inventoryPage()));
            break;
            case 3:
              Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => alertsPage()));
            break;
            default:
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: [
          NavBarItem(
            active: selected[0],
            icon: Icons.dashboard,
            name: 'dashboard',
            touched: (){
              setState(() {
                select(0);
              });
            },
          ),
           NavBarItem(
            active: selected[1],
            icon: Icons.report,
            name: 'Report',
            touched: (){
              setState(() {
                select(1);
              });
            },
          ),
          NavBarItem(
            active: selected[2],
            icon: Icons.report,
            name: 'Inventory',
            touched: (){
              setState(() {
                select(2);
              });
            },
          ),
           NavBarItem(
            active: selected[3],
            icon: Icons.person,
            name: 'Alerts',
            touched: (){
              setState(() {
                select(3);
              });
            },
          ),
           NavBarItem(
            active: selected[4],
            icon: Feather.settings,
            name: 'settings',
            touched: (){
              setState(() {
                select(4);
              });
            },
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {

  final IconData icon;
  final Function touched;
  final bool active;
  final String name;

  const NavBarItem({super.key, 
    required this.active,
    required this.icon,
    required this.touched,
    required this.name
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem>{
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.touched();
        },
        splashColor: Colors.black,
        hoverColor: Colors.black12,
        child: Container(
          child: Row(
            children: [
              Container(
                height: 60,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      height: 35,
                      width: 5,
                      decoration: BoxDecoration(
                        color: widget.active ? Colors.black : Colors.black12,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                           Icon(
                              widget.icon,
                              color: widget.active ? Colors.black : Colors.black54,
                              size: 19,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: widget.active ? Colors.black : Colors.black54,
                                fontWeight: widget.active ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                        ],
                      ) 
                     
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}