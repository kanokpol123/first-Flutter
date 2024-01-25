// menu_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/api/MenuService.dart';
import '/models/Menu.dart';
import '/screens/FoodCartPage.dart';
import '/models/Order.dart';
import '/bloc/CartBloc.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    try {
      List<MenuItem> menuItems = await MenuService.getMenuItems();
      setState(() {
        _menuItems = menuItems;
      });
    } catch (e) {
      print('Error loading menu items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 14, 116, 21),
        title: Text(
          'เมนูอาหาร',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, Order>(
            builder: (context, cartState) {
              int cartItemsCount = cartState.items.length;
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FoodCartPage(orders: cartState.items),
                    ),
                  );
                },
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: Colors.white,
                    ),
                    if (cartItemsCount > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            '$cartItemsCount',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, Order>(
        builder: (context, cartState) {
          if (_menuItems.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _menuItems[index].name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'ราคา: ${_menuItems[index].price} บาท',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveFromCartEvent(
                              OrderItem(order: _menuItems[index])));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCartEvent(
                              OrderItem(order: _menuItems[index])));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
