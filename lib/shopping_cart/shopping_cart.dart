import 'package:flutter/material.dart';
import 'cart_controller.dart';
import 'item_builder.dart';

//Adding duplicate items creates new entries instead of updating quantity

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final CartController _cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                _cartController.addItem(
                  '1',
                  'Apple iPhone',
                  999.99,
                  discount: 0.1,
                );
                setState(() {});
              },
              child: const Text('Add iPhone'),
            ),
            ElevatedButton(
              onPressed: () {
                _cartController.addItem(
                  '2',
                  'Samsung Galaxy',
                  899.99,
                  discount: 0.15,
                );
                setState(() {});
              },
              child: const Text('Add Galaxy'),
            ),
            ElevatedButton(
              onPressed: () {
                _cartController.addItem('3', 'iPad Pro', 1099.99);
                setState(() {});
              },
              child: const Text('Add iPad'),
            ),
            ElevatedButton(
              onPressed: () {
                _cartController.addItem(
                  '1',
                  'Apple iPhone',
                  999.99,
                  discount: 0.1,
                );
                setState(() {});
              },
              child: const Text('Add iPhone Again'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Items: $_cartController.totalItems'),
                  ElevatedButton(
                    onPressed: () {
                      _cartController.clearCart();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Clear Cart'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Subtotal: \$${_cartController.subtotal.toStringAsFixed(2)}',
              ),
              Text(
                'Total Discount: \$${_cartController.totalDiscount.toStringAsFixed(2)}',
              ),
              const Divider(),
              Text(
                'Total Amount: \$${_cartController.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _cartController.items.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _cartController.items.length,
                itemBuilder: (context, index) {
                  final item = _cartController.items[index];
                  final itemTotal = item.price * item.quantity;

                  return ItemBuilder(
                    item: item,
                    removeItem: () {
                      _cartController.removeItem(item.id);
                      setState(() {});
                    },
                    addToQuantity: () {
                      _cartController.updateQuantity(
                        item.id,
                        item.quantity + 1,
                      );
                      setState(() {});
                    },

                    removeFromQuantity: () {
                      _cartController.updateQuantity(
                        item.id,
                        item.quantity - 1,
                      );
                      setState(() {});
                    },
                    itemTotal: itemTotal,
                  );
                },
              ),
      ],
    );
  }
}
