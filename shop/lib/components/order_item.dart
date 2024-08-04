import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/Order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final Order order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(),
          childrenPadding:
              const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          title: Text(
              'R\$ ${order.total.toStringAsFixed(2).replaceAll('.', ',')}'),
          subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(order.date)),
          children: [
            ListView.builder(
                itemCount: order.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final productOrder = order.products[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productOrder.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        '${productOrder.quantity}x R\$ ${productOrder.price.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
