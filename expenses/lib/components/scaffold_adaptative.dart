import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldAdaptative extends StatelessWidget {
  const ScaffoldAdaptative({
    required this.body,
    required this.getIconButton,
    required this.showChart,
    required this.showTransactionForm,
    required this.setCharView,
    super.key,
  });

  final SafeArea body;
  final Widget Function(IconData icon, Function() fn) getIconButton;
  final bool showChart;
  final void Function(BuildContext) showTransactionForm;
  final void Function() setCharView; 

  @override
  Widget build(BuildContext context) {
    final bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return PlataformaEnum.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (isLandScape)
                    SizedBox(
                      width: 70,
                      child: getIconButton(
                          !showChart
                              ? CupertinoIcons.chart_bar
                              : CupertinoIcons.list_bullet, () => setCharView()),
                    ),
                  getIconButton(Icons.add, () {
                    showTransactionForm(context);
                  })
                ],
              ),
            ),
            child: body,
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Despesas pessoais'),
              actions: [
                if (isLandScape)
                  getIconButton(
                      !showChart ? Icons.grid_on_outlined : Icons.list, () => setCharView()),
                getIconButton(Icons.add, () {
                  showTransactionForm(context);
                })
              ],
              titleTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 20),
              toolbarHeight: 80,
            ),
            body: body,
            floatingActionButton: PlataformaEnum.isIOS
                ? null
                : FloatingActionButton(
                    onPressed: () => showTransactionForm(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation: isLandScape
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerFloat,
          );
  }
}
