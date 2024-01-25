// FoodCartPage.dart
import 'package:flutter/material.dart';
import 'package:testflutter/models/Order.dart';

class FoodCartPage extends StatelessWidget {
  final List<OrderItem> orders;

  FoodCartPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    List<OrderItem> consolidatedOrders = [];

    // Consolidate orders with the same name
    orders.forEach((order) {
      var existingOrder = consolidatedOrders.firstWhere(
        (consolidatedOrder) => consolidatedOrder.order.name == order.order.name,
        orElse: () => OrderItem(order: order.order, quantity: 0),
      );
      if (existingOrder.quantity == 0) {
        consolidatedOrders.add(order);
      } else {
        existingOrder.quantity += order.quantity;
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 14, 116, 21),
        title: Text(
          'รถเข็น',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: 30.0,
                Icons.arrow_back,
                color: Color.fromARGB(255, 247, 248, 249),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Items:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: consolidatedOrders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      consolidatedOrders[index].order.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text('จำนวน: ${consolidatedOrders[index].quantity}'),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ผลลัพธ์:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'จำนวนทั้งหมด: ${consolidatedOrders.fold(0, (sum, order) => sum + order.quantity)} รายการ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'ราคารวม: ${consolidatedOrders.fold(0, (sum, order) => sum + order.order.price * order.quantity)} บาท',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
