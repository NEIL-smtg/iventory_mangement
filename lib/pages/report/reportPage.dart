import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';
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
              scrollingContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget scrollingContainer() {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmallScreen = constraints.maxWidth < 600;
              return isSmallScreen ? _buildColumnLayout() : _buildRowLayout();
            },
          ),
          const SizedBox(height: 50),
          itemStorage(),
        ],
      ),
    ),
  );
}

Widget _buildColumnLayout() {
  return Column(
    children: [
      Center(
        child: ProductChart(),
      ),
      const SizedBox(height: 20),
      Center(
        child: StorageChart(),
      ),
    ],
  );
}

Widget _buildRowLayout() {
  return Row(
    children: [
      Expanded(
        child: Center(
          child: ProductChart(),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Center(
          child: StorageChart(),
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

Widget itemStorage(){
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          buildItemIndicator('Fish', 0.5, <Color>[Colors.orange, Colors.yellow]),
          const SizedBox(width: 20),
          buildItemIndicator('Vegetable', 0.9, <Color>[Colors.red, Colors.orange]),
          const SizedBox(width: 20),
          buildItemIndicator('Soda', 0.2, <Color>[Colors.greenAccent, Colors.green]),
          const SizedBox(width: 20),
          buildItemIndicator('Other', 0.67, <Color>[Colors.orange, Colors.yellow]),
          const SizedBox(width: 20),
        ],
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
      width: 50,
      header: '${(percent * 100).toString()}%',
      footer: name,
    );
}