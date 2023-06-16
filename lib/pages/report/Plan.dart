import 'package:flutter/material.dart';
import 'package:inventory_management/navigationBar/NavMenu.dart';

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

  Widget scrollingContainer(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            smtg(),
          ],
        ),
      ),
    );
  }

  Widget smtg(){
    return Container(
      
    );
  }
}

class ProductRow {
  bool isExpanded = false;
  String selectedProduct = '';
  String quantity = '';

  DataRow buildDataRow() {
    return DataRow(cells: [
      DataCell(Text(selectedProduct)),
      DataCell(TextField(
        onChanged: (value) {
          quantity = value;
        },
        decoration: InputDecoration(
          hintText: 'Enter quantity',
        ),
      )),
    ], onSelectChanged: (bool? selected) {
      if (selected != null && selected) {
        // Toggle expansion on row selection
        toggleExpansion();
      }
    });
  }

  void toggleExpansion() {
    if (isExpanded) {
      // Collapse the row
      isExpanded = false;
      // Remove the row from the list if the product is not selected
      if (selectedProduct.isEmpty) {
        removeRow();
      }
    } else {
      // Expand the row
      isExpanded = true;
      // Add a new row if this is the last row in the list
      if (this == productRows.last) {
        addRow();
      }
    }
  }

  void removeRow() {
    productRows.remove(this);
  }

  void addRow() {
    productRows.add(ProductRow());
  }
}

List<ProductRow> productRows = [ProductRow()];