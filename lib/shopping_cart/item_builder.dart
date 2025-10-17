import 'package:flutter/material.dart';

import 'cart_model.dart';
class ItemBuilder extends StatelessWidget {
  final CartItem item;
  final void Function()? removeFromQuantity;
  final void Function()? addToQuantity;
  final void Function()? removeItem;
  final double itemTotal;
  const ItemBuilder({
    super.key,
    required this.item,
    required this.removeItem,
    required this.addToQuantity,
    required this.removeFromQuantity,
    required this.itemTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${item.price.toStringAsFixed(2)} each'),
            if (item.discount > 0)
              Text(
                'Discount: ${(item.discount * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.green),
              ),
            Text('Item Total: \$${itemTotal.toStringAsFixed(2)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: removeFromQuantity,
              icon: const Icon(Icons.remove),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('${item.quantity}'),
            ),
            IconButton(onPressed: addToQuantity, icon: const Icon(Icons.add)),
            IconButton(
              onPressed: removeItem,
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

