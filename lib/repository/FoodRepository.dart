// menu_repository.dart
import '/models/Menu.dart';
import '/api/MenuService.dart';

//call api
class FoodRepository {
  
  List<MenuItem> _menuItems = [];
  List<MenuItem> get menuItems => _menuItems;

  Future<void> loadMenuItems() async {
    try {
      List<MenuItem> menuItems = await MenuService.getMenuItems();
      _menuItems = menuItems;
    } catch (e) {
      print('Error loading menu items: $e');
    }
  }
}
