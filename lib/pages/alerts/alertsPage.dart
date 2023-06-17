import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          AlertCard(
            title: 'Low Stock',
            description: 'SKU-001 is running low on stock.',
            icon: Icons.shopping_cart,
            iconColor: Colors.orange,
          ),
          SizedBox(height: 16.0),
          AlertCard(
            title: 'Price Change',
            description: 'The price of SKU-002 has changed.',
            icon: Icons.attach_money,
            iconColor: Colors.blue,
          ),
          SizedBox(height: 16.0),
          AlertCard(
            title: 'Out of Stock',
            description: 'SKU-003 is out of stock.',
            icon: Icons.remove_shopping_cart,
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }
}


class AlertCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const AlertCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  @override
  _AlertCardState createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> {
  bool isRead = false;

  void markAsRead() {
    setState(() {
      isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.iconColor,
              size: 48.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: isRead ? null : markAsRead,
                    child: Text('Read'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget alertsPage() {
  return AlertsPage();
}
