import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/scaffold_adaptative.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

 class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.light,
            primary: Colors.black,
            secondary: const Color(0xff8C552E)),
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleSmall: TextStyle(
                color: const Color.fromARGB(255, 110, 110, 110),
                fontSize: MediaQuery.textScalerOf(context).scale(15)),
            titleLarge: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.orange),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't1',
    //     description: 'Gasto1',
    //     value: 150,
    //     date: DateTime.now().subtract(Duration(days: 1))),
    // Transaction(
    //     id: 't2',
    //     description: 'Gasto2',
    //     value: 250,
    //     date: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     id: 't3',
    //     description: 'Gasto3',
    //     value: 350,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: 't4',
    //     description: 'Gasto4',
    //     value: 450,
    //     date: DateTime.now().subtract(Duration(days: 4))),
    // Transaction(
    //     id: 't5',
    //     description: 'Gasto5',
    //     value: 550,
    //     date: DateTime.now().subtract(Duration(days: 5))),
    // Transaction(
    //     id: 't6',
    //     description: 'Gasto6',
    //     value: 650,
    //     date: DateTime.now().subtract(Duration(days: 6))),
    // Transaction(
    //     id: 't7',
    //     description: 'Gasto7',
    //     value: 750,
    //     date: DateTime.now().subtract(Duration(days: 7))),
    // Transaction(
    //     id: 't8',
    //     description: 'Gasto8',
    //     value: 850,
    //     date: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     id: 't9',
    //     description: 'Gasto9',
    //     value: 950,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: 't10',
    //     description: 'Gasto10',
    //     value: 1050,
    //     date: DateTime.now().subtract(Duration(days: 1))),
    // Transaction(
    //     id: 't11',
    //     description: 'Gasto11',
    //     value: 1150,
    //     date: DateTime.now().subtract(Duration(days: 5))),
  ];
  bool _showChart = false;

  _addTransaction(String description, double value, DateTime data) {
    if (description.isNotEmpty && value > 0) {
      final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        description: description,
        value: value,
        date: data,
      );

      setState(() {
        _transactions.add(newTransaction);
      });

      Navigator.of(context).pop();
    }
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((x) => x.id == id);
    });
  }

  _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransactionForm(_addTransaction),
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((x) =>
            x.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return PlataformaEnum.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  _setCharView() {
    setState(() {
      _showChart = !_showChart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final avaliableHeight = MediaQuery.of(context).size.height -
        50 -
        MediaQuery.of(context).padding.top;

    final body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandScape)
              SizedBox(
                height: avaliableHeight * (isLandScape ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: isLandScape ? avaliableHeight : avaliableHeight * 0.7,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return ScaffoldAdaptative(
      body: body,
      getIconButton: _getIconButton,
      showChart: _showChart,
      showTransactionForm: _showTransactionForm,
      setCharView: _setCharView,
    );
  }
}
