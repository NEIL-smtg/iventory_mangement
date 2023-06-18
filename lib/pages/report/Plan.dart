import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';
import 'package:inventory_management/pages/report/purchasingList.dart';

final int addingValue = 0;

class Plan extends StatefulWidget {
  final int planNum;

  const Plan({super.key, required this.planNum});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  int planNum = 0;
  bool isCollapsed = true;
  double screenWidth = 0, screenHeight = 0;
  final Duration duration = const Duration(milliseconds: 300);

  final List<String> attributes = ['Product Code - Product Name', 'Quantity'];
  String selectedAttribute = 'Add special order (if any):';

  List<TableRowData> tableData = [];
  List<String> dropdownItems = ['Conduit Pipe', 'Pipe T Joint', 'Valve','Water Pump','Bolt','Screw'];
  List<TextEditingController> textControllers = [];

  List<double> itemsPrice = [5.9, 3.9, 11.9];

  double budget = 0;
  double moneyNow = 33387; 

  bool added = false;

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addRow() {
    setState(() {
      tableData.add(TableRowData());
      textControllers.add(TextEditingController());
    });
  }

  void saveData() {
    List<List<String>> formattedData = [];

    setState(() {
        added = true;
        moneyNow += (tableData.length * 850).toDouble();
        tableData.clear();
        tableData = [];
    });

    for (var rowData in tableData) {
      if (rowData.isValid()) {
        List<String> data = [rowData.selectedItem!, rowData.textValue!];
        formattedData.add(data);
      }
    }
    print(formattedData);
  }

  void carryToNextPage(){
    Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => purchasingList(budget: budget, planNum: planNum, added: added,)));
  }

  @override
  void initState() {
    super.initState();
    planNum = widget.planNum;
  }

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
                      Text(
                        '${getTitle()}',
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

  String getTitle(){
    if (planNum == 1){
      return 'Best Seller Plan';
    }
    else if (planNum == 2){
      return 'Balanced Plan';
    }
    else{
      return 'Risk-free Plan';
    }
  }

  Widget scrollingContainer(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            productTable(),
            const SizedBox(height: 30),
            infoTable(),
            const SizedBox(height: 20),
            nxtPageConfirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget productTable(){
    return Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: addRow,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
              'Add row',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            ),
          ),
          const SizedBox(height: 20),
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FractionColumnWidth(0.5),
              1: FractionColumnWidth(0.5),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Product code', // Replace with your attribute name
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Quantity', // Replace with your attribute name
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ],
              ),
              for (int i = 0; i < tableData.length; i++)
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: DropdownButtonFormField<String>(
                          value: tableData[i].selectedItem,
                          items: dropdownItems.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              tableData[i].selectedItem = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: textControllers[i],
                          decoration: const InputDecoration(
                            labelText: 'amount >= 1',
                          ),
                          onChanged: (value) {
                            setState(() {
                              tableData[i].textValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
  }

  Widget infoTable() {
    if (planNum == 3)
      return Container();
    return DataTable(
      columns: const [
        DataColumn(label: Text('Money needed now (RM)')),
        DataColumn(label: Text('Money to buy (RM)')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text(moneyNow.toString())),
          DataCell(
            TextFormField(
             controller: _controller,
             decoration: InputDecoration(
              labelText: 'Your investment..',
            ),
            onChanged: (value) {
              setState(() {
                budget = double.parse(value);
              });
            },
          )),
        ]),
      ],
    );
  }

  Widget nxtPageConfirmBtn(){
    return ElevatedButton(
      onPressed: carryToNextPage,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'Confirm',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class TableRowData {
  String? selectedItem;
  String? textValue;

  bool isValid() {
    return selectedItem != null && textValue != null;
  }
}
