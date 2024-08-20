import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
                style: const TextStyle(color: Colors.white),
              ),
              background: Hero(
                tag: product.id,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage(
                          'assets/images/product-placeholder.png'),
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                      begin: Alignment(0, 0.8),
                      end: Alignment(0, 0),
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.6),
                        Color.fromRGBO(0, 0, 0, 0),
                      ],
                    )))
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    product.description,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 800,
                )
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
