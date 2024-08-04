import 'dart:io';
import 'dart:mirrors';

abstract class Produto{
  
  String? nome;
  double? valor;


   exibirProduto(){
    print('O produto $nome tem o valor de R\$$valor');
  }
}

class Ps5 extends Produto{
  @override
  String? get nome => super.nome;
  double? get valor => super.valor;
  @override
  void exibirProduto() {
    super.exibirProduto();
  }
}



main() {

  var ps5 = new Ps5();
  ps5.nome = 'PS5';
  ps5.valor = 1000;
  ps5.exibirProduto();
}
