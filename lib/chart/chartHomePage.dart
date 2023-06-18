import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:inventory_management/constant/Constants.dart';

Widget Chart()
{
  return Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    runAlignment: WrapAlignment.start,
    spacing: 50,
    runSpacing: 20,
    children: <Widget>[
      ProductChart(),
      StorageChart(),
      remainingStock(),
      stockChart(),
    ]
  );
}

Widget StorageChart()
{
  double ratio = 4213/11960;
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
              percent: ratio,
              progressColor: const Color.fromARGB(255, 7, 112, 10),
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration:  (ratio * 2000).toInt(),
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

Widget stockChart(){
  List<SalesData> salesData = getSalesData();

  LineSeries<SalesData, int> series1 = LineSeries<SalesData, int>(
    dataSource: salesData,
    name: 'Items in stocks',
    xValueMapper: (SalesData data, _) => data.days,
    yValueMapper: (SalesData data, _) => data.items,
  );

  LineSeries<SalesData, int> series2 = LineSeries<SalesData, int>(
    dataSource: salesData,
    name: 'Sold items',
    xValueMapper: (SalesData data, _) => data.days,
    yValueMapper: (SalesData data, _) => data.sold,
  );

  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(20),
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Last 90 Days'),
      ),
      primaryYAxis: CategoryAxis(
        title: AxisTitle(text: 'Stock Count'),
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.auto,
      ),
      series: <ChartSeries>[
        series1,
        series2,
      ]
    ),
  );
}

Widget remainingStock(){
  List<lastMonthStockList> lst = getRemainingStockList();
  List<lastMonthStockList> plot1 = [];
  List<lastMonthStockList> plot2 = [];
  List<lastMonthStockList> plot3 = [];

  for (int i = 0; i < lst.length; i++) {
    if (i < 3){
      plot1.add(lst[i]);
    }
    else if (i < 6){
      plot2.add(lst[i]);
    }
    else if (i < 9){
      plot3.add(lst[i]);
    }
  }

  BarSeries<lastMonthStockList, String> series1 = BarSeries<lastMonthStockList, String>(
    dataSource: plot1,
    name: 'March',
    xValueMapper: (lastMonthStockList stlst, _) => stlst.name,
    yValueMapper: (lastMonthStockList stlst, _) => stlst.count,
  );

  BarSeries<lastMonthStockList, String> series2 = BarSeries<lastMonthStockList, String>(
    dataSource: plot2,
    name: 'April',
    xValueMapper: (lastMonthStockList stlst, _) => stlst.name,
    yValueMapper: (lastMonthStockList stlst, _) => stlst.count,
  );

  BarSeries<lastMonthStockList, String> series3 = BarSeries<lastMonthStockList, String>(
    dataSource: plot3,
    name: 'May',
    xValueMapper: (lastMonthStockList stlst, _) => stlst.name,
    yValueMapper: (lastMonthStockList stlst, _) => stlst.count,
  );

  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(10),
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Product Category'),
      ),
      primaryYAxis: CategoryAxis(
        title: AxisTitle(text: 'Stock Count'),
      ),
      legend: Legend(
        isVisible: true,
      ),
      series: <ChartSeries>[
        series1,
        series2,
        series3,
      ],
    ),
  );
}
