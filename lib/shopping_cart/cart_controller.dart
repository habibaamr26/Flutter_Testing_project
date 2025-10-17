import 'cart_model.dart';

class CartController {
  final List<CartItem> items = [];

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final index = items.indexWhere((item) => item.id == id);

    if (index != -1) {
      items[index].quantity += 1;
    } else {
      items.add(
        CartItem(
          id: id,
          name: name,
          price: price,
          discount: discount,
          quantity: 1,
        ),
      );
    }
  }

  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  void updateQuantity(String id, int newQuantity) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (newQuantity <= 0) {
        items.removeAt(index);
      } else {
        items[index].quantity = newQuantity;
      }
    }
  }

  void clearCart() {
    items.clear();
  }

  double get subtotal {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  ///
  double get totalDiscount {
    double discount = 0;
    for (var item in items) {
      discount += item.price * item.discount * item.quantity;
    }
    return discount;
  }

  ///
  double get totalAmount {
    return subtotal - totalDiscount;
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}
