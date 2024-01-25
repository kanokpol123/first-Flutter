import 'Menu.dart';

class Order {
  final int id;
  final List<OrderItem> items;

  Order({required this.id, required this.items});

  Order copyWithUpdatedItems(List<OrderItem> newItems) {
    return Order(id: this.id, items: newItems);
  }
}

class OrderItem {
  final MenuItem order;
  int quantity;

  OrderItem({required this.order, this.quantity = 1});
}
