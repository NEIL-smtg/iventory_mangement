
import 'package:flutter/material.dart';
import 'dart:math';


class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Manager'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildSection(
                context,
                Colors.white,
                Colors.blue,
                Icons.add_circle,
                'Add Product',
                () {
                  // Handle section 1 button tap
                  print('Section 1 button tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstSectionPage()),
                  );
                },
              ),
            ),
            Expanded(
              child: _buildSection(
                context,
                Colors.white,
                Colors.orange,
                Icons.update,
                'Update Purchasing',
                () {
                  // Handle section 2 button tap
                  print('Section 2 button tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondSectionPage()),
                  );
                },
              ),
            ),
            Expanded(
              child: _buildSection(
                context,
                Colors.white,
                Colors.red,
                Icons.history,
                'Sales History',
                () {
                  // Handle section 3 button tap
                  print('Section 3 button tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdSectionPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    Color backgroundColor,
    Color iconColor,
    IconData icon,
    String title,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 64,
                    color: iconColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_forward,
                  size: 35,
                ),
                label: Text(
                  '',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class FirstSectionPage extends StatefulWidget {
  @override
  _FirstSectionPageState createState() => _FirstSectionPageState();
}

class _FirstSectionPageState extends State<FirstSectionPage> {
  List<DataRow> _rows = [];
  int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Add initial data rows
    _addDataRow('SKU-001', 'Supplier 1', 10, 20.0, 19.0, 25.0, 5, 10, 'Refill');
    _addDataRow('SKU-002', 'Supplier 2', 15, 18.5, 18.5, 22.0, 6, 12, 'Alert');
    _addDataRow('SKU-003', 'Supplier 3', 21, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-004', 'Supplier 4', 22, 22.0, 21.5, 27.0, 4, 8,'Alert');
    _addDataRow('SKU-005', 'Supplier 5', 23, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-006', 'Supplier 6', 23, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-007', 'Supplier 7', 24, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-008', 'Supplier 8', 26, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-009', 'Supplier 9', 27, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-010', 'Supplier 9', 28, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-011', 'Supplier 1', 28, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-012', 'Supplier 2', 30, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-013', 'Supplier 3', 23, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    _addDataRow('SKU-014', 'Supplier 2', 9, 22.0, 21.5, 27.0, 4, 8, 'Alert');
    // Add more initial data rows as needed
  }

  void _addDataRow(
    String sku,
    String supplier,
    int quantity,
    double buyPriceAvg,
    double latestBuyPrice,
    double sellPriceAvg,
    int leadTimeAvg,
    int leadTimeMax,
    String status,
  ) {
    setState(() {
      _rows.add(DataRow(
        cells: [
          DataCell(Text(sku)),
          DataCell(Text(supplier)),
          DataCell(Text(quantity.toString())),
          DataCell(Text(buyPriceAvg.toString())),
          DataCell(Text(latestBuyPrice.toString())),
          DataCell(Text(sellPriceAvg.toString())),
          DataCell(Text(leadTimeAvg.toString())),
          DataCell(Text(leadTimeMax.toString())),
          DataCell(Text(status)),
          DataCell(
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Handle edit button press
                print('Edit button pressed for SKU: $sku');
              },
            ),
          ),
        ],
      ));
    });
  }

  void _sortRows(int columnIndex, bool ascending) {
    setState(() {
      _rows.sort((a, b) {
        final aValue = a.cells[columnIndex].child as Text;
        final bValue = b.cells[columnIndex].child as Text;
        return ascending
            ? aValue.data!.compareTo(bValue.data!)
            : bValue.data!.compareTo(aValue.data!);
      });
    });
  }

  List<DataColumn> _getDataColumns() {
    return [
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.category),
            SizedBox(width: 4),
            Text('Product SKU'),
          ],
        ),
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.supervisor_account),
            SizedBox(width: 4),
            Text('Supplier'),
          ],
        ),
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 4),
            Text('Quantity'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.attach_money),
            SizedBox(width: 4),
            Text('Buy Price Avg'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.update),
            SizedBox(width: 4),
            Text('Latest Buy Price'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.sell),
            SizedBox(width: 4),
            Text('Sell Price Avg'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(width: 4),
            Text('Lead Time Avg'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.timelapse),
            SizedBox(width: 4),
            Text('Lead Time Max'),
          ],
        ),
        numeric: true,
        onSort: (columnIndex, ascending) {
          _sortRows(columnIndex, ascending);
        },
      ),
      DataColumn(
        label: Row(
          children: [
            Icon(Icons.circle, color: Colors.red),
            SizedBox(width: 4),
            Text('Status'),
          ],
        ),
      ),
      DataColumn(
        label: Text('Actions'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = min(startIndex + _rowsPerPage, _rows.length);

    return Scaffold(
      appBar: AppBar(
        title: Text('First Section Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: 0,
                sortAscending: true,
                columns: _getDataColumns(),
                rows: _rows.sublist(startIndex, endIndex),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentPage = max(0, _currentPage - 1);
                    });
                  },
                  icon: Icon(Icons.chevron_left),
                ),
                Text('Page ${_currentPage + 1}'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentPage =
                          min((_rows.length - 1) ~/ _rowsPerPage, _currentPage + 1);
                    });
                  },
                  icon: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}










///---------

class SecondSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Section Page'),
      ),
      body: Center(
        child: Text(
          'Second Section Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ThirdSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Section Page'),
      ),
      body: Center(
        child: Text(
          'Third Section Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}


Widget inventoryPage() {
  return InventoryPage();
}