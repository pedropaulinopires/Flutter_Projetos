import 'package:expenses/components/button_adaptative.dart';
import 'package:expenses/components/date_picker_adaptative.dart';
import 'package:expenses/components/text_field_adaptative.dart';
import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this._addTransaction, {super.key});
  final void Function(String description, double value, DateTime date)
      _addTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _dateSelected = DateTime.now();
  _onSubmit() {
    widget._addTransaction(descriptionController.text,
        double.tryParse(valueController.text) ?? 0, _dateSelected);
  }

  

  @override
  Widget build(BuildContext context) {
    final bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      height: landscape
          ? MediaQuery.of(context).size.height
          : (MediaQuery.of(context).size.height * (PlataformaEnum.isIOS ? 0.4: 0.3)) +
              MediaQuery.of(context).viewInsets.bottom,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldAdaptative(
                    descriptionController, _onSubmit, null, 'Descrição'),
                TextFieldAdaptative(
                    valueController,
                    _onSubmit,
                    const TextInputType.numberWithOptions(decimal: true),
                    'Valor R\$')
              ],
            ),
            DatePickerAdaptative(_dateSelected, (dataTime){
              setState(() {
                _dateSelected = dataTime;
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ButtonAdaptative('Nova Transação', _onSubmit)],
            )
          ],
        ),
      ),
    );
  }
}
