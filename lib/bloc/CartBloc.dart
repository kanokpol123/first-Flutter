// bloc/CartBloc.dart
import 'package:bloc/bloc.dart';
import 'package:testflutter/models/Order.dart';

// Define the events
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final OrderItem order;
  AddToCartEvent(this.order);
}

class RemoveFromCartEvent extends CartEvent {
  final OrderItem order;
  RemoveFromCartEvent(this.order);
}

class CartBloc extends Bloc<CartEvent, Order> {
  CartBloc() : super(Order(id: 1, items: [])) {
    on<AddToCartEvent>(_onAddItem);
    on<RemoveFromCartEvent>(_onRemoveItem);
  }

  void _onAddItem(AddToCartEvent event, Emitter<Order> emit) {
    final updateItems = List<OrderItem>.from(state.items)..add(event.order);
    emit(state.copyWithUpdatedItems(updateItems));
  }

 void _onRemoveItem(RemoveFromCartEvent event, Emitter<Order> emit) {
    final updateItems = List<OrderItem>.from(state.items);
    
    // Find the index of the item with the specified order ID
    int indexToRemove = updateItems.indexWhere(
      (item) => item.order.id == event.order.order.id,
    );

    // Remove the item if found
    if (indexToRemove != -1) {
      updateItems.removeAt(indexToRemove);
      emit(state.copyWithUpdatedItems(updateItems));
    }
  }
}
