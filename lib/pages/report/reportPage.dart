import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';
import 'package:inventory_management/pages/report/Plan.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:inventory_management/constant/Constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class reportPage extends StatefulWidget {
  const reportPage({Key? key}) : super(key: key);

  @override
  _MyReportPage createState() => _MyReportPage();
  
}

class _MyReportPage extends State<reportPage> {
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
                      const Text(
                        'Report',
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
              scrollingContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget scrollingContainer(context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          ProductChart(),
          Container(
            padding: const EdgeInsets.all(30),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool isSmallScreen = constraints.maxWidth < 550;
                return isSmallScreen ? _buildColumnLayout() : _buildRowLayout();
              },
            ),
          ),
          reportButtons(context),
        ],
      ),
    ),
  );
}

Widget _buildColumnLayout() {
  return Column(
    children: [
      Center(
        child: StorageChart(),
      ),
      const SizedBox(height: 20),
      Center(
        child: itemStorage(),
      ),
    ],
  );
}

Widget _buildRowLayout() {
  return Row(
    children: [
      Expanded(
        child: Center(
          child: StorageChart(),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Center(
          child: itemStorage(),
        ),
      ),
    ],
  );
}

Widget ProductChart(){
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  List<Stocks> _chartData = getStocks();

  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(10),
    child: SfCircularChart(
      title: ChartTitle(
        text: 'Product Quantity Chart',
        alignment: ChartAlignment.center,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
      PieSeries<Stocks, String>(
        dataSource: _chartData,
        xValueMapper: (Stocks data,_) => data.type,
        yValueMapper: (Stocks data,_) => data.count,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        radius: '100',
      )
    ]),
  );
}

Widget StorageChart()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(50),
            child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 25,
              backgroundColor: Colors.grey.shade500,
              percent: 0.88,
              progressColor: const Color.fromARGB(255, 7, 112, 10),
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration:  (0.88 * 2000).toInt(),
              center: const Text(
                'Storage Overview',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                ),
              ),
            ),
            ),
        ),
    ],
  );
}

Widget itemStorage() {
  return Material(
    elevation: 8,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.all(20),
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildItemIndicator('Fish', 0.5, <Color>[Colors.yellow, Colors.orange]),
            const SizedBox(width: 20),
            buildItemIndicator('Vegetable', 0.2, <Color>[Colors.orange, Colors.red]),
            const SizedBox(width: 20),
            buildItemIndicator('Soda', 0.9, <Color>[Colors.green, Colors.greenAccent]),
            const SizedBox(width: 20),
            buildItemIndicator('Other', 0.67, <Color>[Colors.greenAccent, Colors.yellow]),
          ],
        ),
      ),
    ),
  );
}

Widget buildItemIndicator(String name, double percent, List<Color> c){
  return VerticalBarIndicator(
      percent: percent,
      height: 200,
      animationDuration: const Duration(seconds: 1),
      circularRadius: 15,
      color: c,
      width: 20,
      header: '${(percent * 100).toString()}%',
      footer: name,
    );
}

Widget reportButtons(context){
  return Container(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
    child: IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_reportButton('Best Seller', 'bestseller.png', context),
          const SizedBox(width: 20),
          build_reportButton('Balanced', 'balance.png', context),
          const SizedBox(width: 20),
          build_reportButton('Risk-free', 'riskfree.png', context),
          const SizedBox(width: 30),
        ],
      ),
    ),
  );
}

Widget build_reportButton(String label, String imgPath, context) {
  return Material(
    elevation: 10,
    borderRadius: BorderRadius.circular(15),
    child: Container(
        width: 150,
        height: 180,
        padding: const EdgeInsets.all(20),
        child: TextButton(
          onPressed: () {
            if (label == 'Best Seller'){
               Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => const Plan(planNum: 1)));
            }
            else if (label == 'Balanced'){
              Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => const Plan(planNum: 2)));
            }
            else{
              Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => const Plan(planNum: 3)));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imgPath,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
    ),
  );
}
