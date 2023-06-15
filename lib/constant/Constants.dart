import 'dart:math';

class Constants {
  
  static const Constants instance = Constants();

  const Constants();

  double getTotalRevenue()
  {
    return (200000);
  }

  double getCashAvailable()
  {
    return (20000);
  }

  double getItemsInStock()
  {
    return (350000);
  }

  double getMonthlySale()
  {
    return (200000);
  }

  double getMonthlySaleAvg()
  {
    return (69000);
  }
}


List<lastMonthStockList> getRemainingStockList(){
  Random random = Random();

  List<lastMonthStockList> lst = [
    lastMonthStockList('A', random.nextInt(1000) + 1000, 'March'),
    lastMonthStockList('B', random.nextInt(1000) + 1000, 'March'),
    lastMonthStockList('C', random.nextInt(1000) + 1000, 'March'),
    lastMonthStockList('A', random.nextInt(1000) + 2000, 'April'),
    lastMonthStockList('B', random.nextInt(1000) + 2000, 'April'),
    lastMonthStockList('C', random.nextInt(1000) + 3000, 'April'),
    lastMonthStockList('A', random.nextInt(1000) + 3000, 'May'),
    lastMonthStockList('B', random.nextInt(1000) + 3000, 'May'),
    lastMonthStockList('C', random.nextInt(1000) + 3000, 'May'),
  ];
  return lst;
}

class lastMonthStockList{
  lastMonthStockList(this.name, this.count, this.month);
  final String name;
  final int count;
  final String month;
}

List<SalesData> getSalesData(){
  int maxDays = 90;
  Random rd = Random();

  int maxStock = rd.nextInt(20000) + 20000;
  int sold;
  int stepper = 0;
  List<SalesData> lst = [];

  for (int i = 1; i <= maxDays; i++) {
    sold = rd.nextInt(10000) + stepper;
    lst.add(
      SalesData(
        i,
        sold,
        maxStock - sold
      )
    );
    stepper += 200;
  }
  return lst;
}

class SalesData {
  SalesData(this.days, this.items, this.sold);
  final int days;
  final int items;
  final int sold;
}

List<Stocks> getStocks(){
  final List<Stocks> chartData = [
    Stocks('apple', 5678),
    Stocks('orange', 6323),
    Stocks('guava', 2342),
    Stocks('100 plus', 123),
    Stocks('cola', 534),
    Stocks('durian', 88),
    Stocks('other', 789),
  ];
  return chartData;
}

class Stocks{
  Stocks(this.type, this.count);
  final String type;
  final int count;
}

