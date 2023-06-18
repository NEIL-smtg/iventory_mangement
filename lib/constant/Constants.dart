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
    Stocks( 'Conduit Pipe', 200),
    Stocks('Pipe T Joint', 123),
    Stocks('Valve', 23),
    Stocks('Water Pump', 5),
    Stocks('Bolt', 6511),
    Stocks('Screw', 8081),
  ];
  return chartData;
}

class Stocks{
  Stocks(this.type, this.count);
  final String type;
  final int count;
}

class purchasingData{ 
  String code;
  String name;
  int currentStorage;
  int maxStorage;
  int required;
  int suggested;
  double cost;

  purchasingData(this.code, this.name, this.currentStorage, 
          this.maxStorage, this.required, 
          this.suggested, this.cost);
}

List<purchasingData> get60kPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 622, 1354, 11509),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 562, 14050),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 490, 24500),
    purchasingData('RP91909', 'Water Pump', 5, 63, 145, 50, 6250),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 1720, 3440),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 0, 0),
  ];
  return lst;
}

List<purchasingData> get45kPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 622, 1041, 8849),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 425, 10625),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 385, 19250),
    purchasingData('RP91909', 'Water Pump', 5, 63, 145, 39, 4875),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 40, 80),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 0, 0),
      ];
  return lst;
}

List<purchasingData> getAddedPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 722, 755, 7267.5),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 329, 8225),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 334, 16700),
    purchasingData('RP91909', 'Water Pump', 5, 63, 145, 68, 8500),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 0, 0),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 0, 0),
      ];
  return lst;
}

List<purchasingData> get40kPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 622, 755, 6417.5),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 329, 8225),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 334, 16700),
    purchasingData('RP91909', 'Water Pump', 5, 63, 145, 68, 8500),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 0, 0),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 0, 0),
      ];
  return lst;
}

List<purchasingData> getRFPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 622, 1444, 12274),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 655, 16375),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 591, 29550),
    purchasingData('RP91909', 'Water Pump', 5, 63, 121, 68, 15125),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 4687, 9374),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 1479, 4437),
      ];
  return lst;
}

List<purchasingData> getPurchasingData(){
  final List<purchasingData> lst = [
    purchasingData('RP91907', 'Conduit Pipe', 200, 822, 622, 1041, 8849),
    purchasingData('RP91893', 'Pipe T Joint', 123, 389, 266, 425, 10625),
    purchasingData('RP91908', 'Valve', 23, 307, 284, 385, 19250),
    purchasingData('RP91909', 'Water Pump', 5, 63, 145, 39, 4875),
    purchasingData('RP91894', 'Bolt', 6511, 5599, 0, 40, 80),
    purchasingData('RP91895', 'Screw', 8081, 4780, 0, 0, 0),
  ];
  return lst;
}

class SalesHistory{
  String productCode;
  String date;
  int quantity;
  double price;
  String invoiceNum;
  String remarks;

  SalesHistory(this.productCode, this.date, this.invoiceNum, 
   this.quantity, this.price, this.remarks);
}

List<String> getSalesHistoryCode(List<SalesHistory> phlst){
  List<String> productCode = [];

  for (SalesHistory ph in phlst){
    productCode.add(ph.productCode);
  }
  return productCode;
}

List<SalesHistory> getSalesHistoryList(){
  List<SalesHistory> lst = [
    SalesHistory('RP91907', '11/6/2023', 'INV11106001-009', 46, 644,  ' '),
    SalesHistory('RP91907', '10/6/2023', 'INV11006001-012', 62, 826,  ' 3 defect items found'),
    SalesHistory('RP91907', '9/6/2023', 'INV10906001-014', 88, 1232,  ' '),
    SalesHistory('RP91907', '8/6/2023', 'INV10806001-008', 32, 448,  ' '),
    SalesHistory('RP91907', '7/6/2023', 'INV10706001-008', 41, 574,  ' '),
    SalesHistory('RP91907', '6/6/2023', 'INV10606001-015', 90, 1260,  ' '),
  ];
  return lst;
}

List<SalesHistory> getAddSalesHistory(){
  List<SalesHistory> lst = [
    SalesHistory("RP91907", '11/6/2023', 'INV11106001-009', 46, 644,  ' '),
    SalesHistory("RP91901", '10/6/2023', 'INV11006001-012', 62, 826,  ' 3 defect items found'),
    SalesHistory("RP91902", '9/6/2023', 'INV10906001-014', 88, 1232,  ' '),

    SalesHistory("RP91893", '8/6/2023', 'INV10806001-008', 32, 448,  ' '),
    SalesHistory("RP91892", '7/6/2023', 'INV10706001-008', 41, 574,  ' '),
    SalesHistory("RP91891", '6/6/2023', 'INV10606001-015', 90, 1260,  ' '),
  ];
  return lst;
}

class ProductHistory{
  String productCode;
  String supplier;
  int quantity;
  double price;
  String orderDate;
  String receivedDate;

  ProductHistory(this.productCode, this.supplier, this.quantity, 
   this.price, this.orderDate, this.receivedDate);
}

List<ProductHistory> getAddProductCode(){
  List<ProductHistory> lst = [
    ProductHistory("RP91907", "KimTeck Trading", 1000, 8500, "21/2/2023", "11/6/2023"),
    ProductHistory("RP91901", "KimTeck Trading", 1000, 8000, "5/5/2023", "20/5/2023"),
    ProductHistory("RP91902", "KimTeck Trading", 1000, 7880, "20/4/2023", "3/5/2023"),

    ProductHistory("RP91893", "KY Hardware", 200, 5000, "28/5/2023", "11/6/2023"),
    ProductHistory("RP91892", "KimTeck Trading", 250, 6500, "14/5/2023", "20/5/2023"),
    ProductHistory("RP91891", "King Tembikar", 150, 3630, "25/4/2023", "3/5/2023"),
  ];
  return lst;
}

List<ProductHistory> getProductHistoryList(){
  List<ProductHistory> lst = [
    ProductHistory("RP91907", "KimTeck Trading", 1000, 8500, "21/2/2023", "11/6/2023"),
    ProductHistory("RP91907", "KimTeck Trading", 1000, 8000, "5/5/2023", "20/5/2023"),
    ProductHistory("RP91907", "KimTeck Trading", 1000, 7880, "20/4/2023", "3/5/2023"),
    ProductHistory("RP91907", "KimTeck Trading", 1000, 7900, "5/4/2023", "17/4/2023"),
    ProductHistory("RP91907", "King Tembikar", 500, 3620, "21/3/2023", "3/4/2023"),
    ProductHistory("RP91907", "KimTeck Trading", 1000, 7000, "5/3/2023", "31/3/2023"),

    ProductHistory("RP91893", "KY Hardware", 200, 5000, "28/5/2023", "11/6/2023"),
    ProductHistory("RP91893", "KimTeck Trading", 250, 6500, "14/5/2023", "20/5/2023"),
    ProductHistory("RP91893", "King Tembikar", 150, 3630, "25/4/2023", "3/5/2023"),
    ProductHistory("RP91893", "KY Hardware", 200, 4200, "8/4/2023", "17/4/2023"),
    ProductHistory("RP91893", "KimTeck Trading", 300, 5700, "25/3/2022", "3/4/2023"),
    ProductHistory("RP91893", "KimTeck Trading", 300, 5630, "24/3/2023", "31/3/2022"),
  ];
  return lst;
}

List<String> getProductHistoryCode(List<ProductHistory> phlst){
  List<String> productCode = [];

  for (ProductHistory ph in phlst){
    productCode.add(ph.productCode);
  }
  return productCode;
}

