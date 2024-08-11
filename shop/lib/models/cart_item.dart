class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  // Método para converter CartItem em um mapa serializável
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }
}
