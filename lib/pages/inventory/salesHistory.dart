import 'package:flutter/material.dart';
import 'package:inventory_management/constant/Constants.dart';

class ThirdSectionPage extends StatefulWidget {
  const ThirdSectionPage({super.key});

  @override
  State<ThirdSectionPage> createState() => _ThirdSectionPageState();
}

class _ThirdSectionPageState extends State<ThirdSectionPage> {
  
  int j = -5;
  List<TableRowData> tableData = [];
  List<SalesHistory> addProductCodeLst = getAddSalesHistory();
  List<SalesHistory> historylst = getSalesHistoryList();
  List<String> dropdownItems = [];
  List<List<TextEditingController>> textControllers = [];

  String? generatedTarget;
  List<SalesHistory> generatedLst = [];

  @override
  void initState(){
    super.initState();
    dropdownItems = getSalesHistoryCode(addProductCodeLst);
  }

  void addRow() {
    setState(() {
      j+=5;
      tableData.add(TableRowData());
      List<TextEditingController> rowControllers = [];
      for (int i = 0; i < 5; i++) {
        rowControllers.add(TextEditingController());
      }
      textControllers.add(rowControllers);
    });
  }

  void saveData() {
    List<List<String>> formattedData = [];

    for (var rowData in tableData) {
      if (rowData.isValid()) {
        List<String> data = [rowData.selectedProduct!, rowData.date!, rowData.quantity!,
                rowData.price!, rowData.invoiceNum!, rowData.remarks!];
        historylst.add(SalesHistory(
          rowData.selectedProduct!, rowData.date!,
          rowData.invoiceNum!, int.parse(rowData.quantity!), double.parse(rowData.price!),
          rowData.remarks!
          ));
        formattedData.add(data);
      }
    }
    setState(() {
      j = -5;
      tableData.clear();
      tableData = [];
      for (var i = 0; i < textControllers.length; i++) {
      for (var j = 0; j < 5; j++) {
        textControllers[i][j].dispose();
      }
    }
    });
    print(formattedData);
  }

  @override
  void dispose() {
    for (var i = 0; i < textControllers.length; i++) {
      for (var j = 0; j < 5; i++) {
        textControllers[i][j].dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales History'),
      ),
      body: updateHistoryPage(context),
    );
  }

  Widget updateHistoryPage(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              addHistoryTable(),
              const SizedBox(height: 30),
              const Text(
                'Here is your detailed Sales history: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              listFinder(),
              const SizedBox(height: 30),
              listGenrator(),
            ],
          ),
        ),
      );
  }

  Widget listFinder() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      spacing: 10,
      children: [
        Container(
          width: 200, // Specify the desired width for the dropdown
          child: DropdownButtonFormField<String>(
            value: generatedTarget,
            items: dropdownItems.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                generatedTarget = value;
              });
            },
          ),
        ),
          ElevatedButton(
            onPressed: generateTargetLst,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Generate',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void generateTargetLst(){
    setState(() {
      generatedLst.clear();
      generatedLst = [];
      for (var elem in historylst) {
        if (elem.productCode == generatedTarget){
          generatedLst.add(elem);
        }
      }
    });
  }

  Widget listGenrator(){
    List<DataRow> _rows = [];
    
    for (var elem in generatedLst) {
      _rows.add(DataRow(
        cells: [
          DataCell(Text(elem.productCode)),
          DataCell(Text(elem.date)),
          DataCell(Text(elem.quantity.toString())),
          DataCell(Text(elem.price.toString())),
          DataCell(Text(elem.invoiceNum.toString())),
          DataCell(Text(elem.remarks.toString())),
          DataCell(
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Handle edit button press
              },
            ),
          ),
        ],
      ));
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text('Product Code')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Price (RM)')),
        DataColumn(label: Text('Invoice Number')),
        DataColumn(label: Text('Remarks')),
        DataColumn(label: Text('Action')),
      ],
      rows: _rows,
    );
  }

  Widget addHistoryTable(){
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
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Product code',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Price (RM)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Invoice Number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Remarks',
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
                            value: tableData[i].selectedProduct,
                            items: dropdownItems.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                tableData[i].selectedProduct = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      for (int j = 0; j < 5; j++)
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: textControllers[i][j],
                              decoration: InputDecoration(
                                labelText: _getLabelText(j),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _updateTableRowData(i, j, value);
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

  void _updateTableRowData(int rowIndex, int controllerIndex, String value) {
  final rowData = tableData[rowIndex];
  switch (controllerIndex) {
    case 0:
      rowData.date = value;
      break;
    case 1:
      rowData.quantity = value;
      break;
    case 2:
      rowData.price = value;
      break;
    case 3:
      rowData.invoiceNum = value;
      break;
    case 4:
      rowData.remarks = value;
      break;
  }
}

  String _getLabelText(int controllerIndex) {
    switch (controllerIndex) {
      case 0:
        return 'date';
      case 1:
        return 'quantity';
      case 2:
        return 'price (RM)';
      case 3:
        return 'Order Date';
      case 4:
        return 'Receive Date';
      default:
        return '';
    }
  }
}

class TableRowData{
  String? selectedProduct;
  String? date;
  String? quantity;
  String? price;
  String? invoiceNum;
  String? remarks;

  bool isValid(){
    return selectedProduct != null && date != null &&
           quantity != null && price != null &&
           invoiceNum != null && remarks != null;
  }
}