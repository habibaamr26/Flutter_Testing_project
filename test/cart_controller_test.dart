import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/shopping_cart/cart_controller.dart';

void main() {
  group("cart controller test", () {
    test('test to add item inside list ', () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 999.99, discount: 0.1);
      expect(cartController.items.length, 1);
      expect(cartController.items[0].id, '10');
    });

    test('test to update quantity of existing item ', () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 999.99, discount: 0.1);
      cartController.updateQuantity('10', 5);
      expect(cartController.items.length, 1);
      expect(cartController.items[0].quantity, 5);
    });

    test('test to remove item from cart ', () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 999.99, discount: 0.1);
      cartController.removeItem('10');
      expect(cartController.items.length, 0);
    });

    test("test to clear cart", () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 999.99, discount: 0.1);
      cartController.addItem('10', 'Apple iPhone', 999.99, discount: 0.1);
      cartController.clearCart();
      expect(cartController.items.length, 0);
    });

    test("test to calculate subtotal", () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 1000.0, discount: 0.1);
      cartController.addItem('11', 'Samsung Galaxy', 500.0, discount: 0.05);
      expect(cartController.subtotal, 1500.0);
    });

    test("test to calculate total discount", () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 1000.0, discount: 0.1);
      cartController.addItem('11', 'Samsung Galaxy', 500.0, discount: 0.05);
      expect(cartController.totalDiscount, 125.0);
    });

    test("test to see total items in list", () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 1000.0, discount: 0.1);
      cartController.addItem('11', 'Samsung Galaxy', 500.0, discount: 0.05);
      expect(cartController.items.length, 2);
      cartController.clearCart();
      expect(cartController.items.length, 0);
    });

    test('test to empty cart should have totals zeros', () {
      CartController cartController = CartController();
      cartController.addItem('10', 'Apple iPhone', 1000.0, discount: 0.1);
      cartController.clearCart();
      expect(cartController.subtotal, 0);
      expect(cartController.totalDiscount, 0);
      expect(cartController.totalAmount, 0);
      expect(cartController.totalItems, 0);
    });


    test('test to item with 100% discount should make totalAmount zero', () {
      CartController cartController = CartController();
      cartController.addItem('1', 'Free Item', 50.0, discount: 1.0);
      expect(cartController.subtotal, 50.0);
      expect(cartController.totalDiscount, 50.0);
      expect(cartController.totalAmount, 0);
    });


    test('test to setting quantity to 0 should remove the item', () {
      final cart = CartController();
      cart.addItem('1', 'Item', 100);
      cart.updateQuantity('1', 0);
      expect(cart.items.length, 0);
    });




  });
}
