import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';
import 'package:inventory_management/constant/Constants.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';


class purchasingList extends StatefulWidget {
  final int     planNum;
  final double  budget;
  final bool added;
  const purchasingList({super.key, required this.planNum, required this.budget, required this.added});

  @override
  State<purchasingList> createState() => _purchasingListState();
}

class _purchasingListState extends State<purchasingList> {
  bool isCollapsed = true;
  double screenWidth = 0, screenHeight = 0;
  final Duration duration = const Duration(milliseconds: 300);

  int planNum = 0;
  double budget = 0;
  bool added = false;

  double total = 0;

  List<purchasingData> datalst = [];

  @override
  void initState() {
    planNum = widget.planNum;
    budget = widget.budget;
    added = widget.added;
  
    if (budget == 60000){
      datalst = get60kPurchasingData();
      total = 59749;
    }
    else if (budget == 45000){
      datalst = get45kPurchasingData();
      total = 43679;
    }
    else if (added){
      datalst = getAddedPurchasingData();
      total = 40692.5;
    }
    else if (budget == 40000){
      datalst = get40kPurchasingData();
      total = 39842.5;
    }
    else if (planNum == 3){
      datalst = getRFPurchasingData();
      total = 87135;
    }
    else{
      datalst = get45kPurchasingData();
      total = 43679;
    }
    datalst.add(purchasingData('', 'Total Cost', -1, 0, 0, 0, total));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return realDesign(context);
  }

  Scaffold realDesign(BuildContext context) {
    return Scaffold(
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
            NavMenu(pageNum: 1),
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
                      Text(
                        'Your purchasing list for next month : ${getPageTitle()} (RM$budget)',
                        style: const TextStyle(
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
              scrollingContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  String getPageTitle(){
    if (planNum == 1){
      return('Best Seller Plan');
    }
    else if (planNum == 2){
      return('Balanced');
    }
    else{
      return('Risk-free');
    }
  }

  Widget scrollingContainer(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            purchasingDataTable(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget purchasingDataTable(){
    return DataTable(
      columns: const [
        DataColumn(label: Text('Product Code')),
        DataColumn(label: Text('Product Name')),
        DataColumn(label: Text('Current Storage Amount')),
        DataColumn(label: Text('Required (at least)')),
        DataColumn(label: Text('Suggested')),
        DataColumn(label: Text('Cost (RM)')),
      ],
      rows:
        datalst.map((data) {
        return DataRow(
          cells: [
            DataCell(Text(data.code)),
            DataCell(Text(data.name)),
            DataCell(itemStorageStatus(data.currentStorage, data.maxStorage)),
            DataCell(Text(data.required.toString())),
            DataCell(Text(data.suggested.toString())),
            DataCell(Text(data.cost.toString())),
          ]
        );
      }).toList(),
    );

  }

  DataRow purchasingTotalRow(){
    return DataRow(
      cells: [
        const DataCell(Text('Total cost')),
        DataCell(Text(budget.toString())),
      ]
    );
  }

  Widget itemStorageStatus(int current, int max){
    if (current == -1)
      return Container();
    double ratio = current / max;
    List<Color> c = [];

    if (ratio > 0.75)
    {
      c.add(Colors.greenAccent);
      c.add(Colors.green);
    }
    else if (ratio > 0.5)
    {
      c.add(Colors.yellow);
      c.add(Colors.greenAccent);
    }
    else if (ratio > 0.25)
    {
      c.add(Colors.yellow);
      c.add(Colors.orange);
    }
    else
    {
      c.add(Colors.orange);
      c.add(Colors.red);
    }
    return Wrap(
      direction: Axis.horizontal,
      children: [
        RotatedBox(
          quarterTurns: 1,
            child: Row(
              children: [
                  buildItemIndicator('', ratio, c),
              ],
            )
          ),
          Text(
            '$current / $max',
             style: const TextStyle(
              fontSize: 10,
            ),
          )
      ],

    );
  }

  Widget buildItemIndicator(String name, double percent, List<Color> c){
    return VerticalBarIndicator(
        percent: percent,
        height: 60,
        animationDuration: const Duration(seconds: 1),
        circularRadius: 5,
        color: c,
        width: 15,
      );
  }
}

