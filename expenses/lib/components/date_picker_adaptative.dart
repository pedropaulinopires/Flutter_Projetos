import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerAdaptative extends StatelessWidget {
  const DatePickerAdaptative(this.dateSelected, this.dateChange, {super.key});

  final DateTime dateSelected;
  final Function(DateTime) dateChange;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.orange,
              ),
              textTheme: Theme.of(context).textTheme),
          child: child!,
        );
      },
    ).then((onValue) {
      if (onValue != null) {
        dateChange(onValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlataformaEnum.isIOS
        ? SizedBox(
          height: PlataformaEnum.isIOS ? 150 : 50,
          child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2000),
              maximumDate: DateTime.now(),
              onDateTimeChanged: dateChange,
              mode: CupertinoDatePickerMode.date,
            ),
        )
        : Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Text(dateSelected == null
                    ? "Nenhuma data selecionada!"
                    : "Data selecionada: ${DateFormat('dd/MM/y').format(dateSelected!)}"),
              ),
              TextButton(
                onPressed: () => _showDatePicker(context),
                child: const Text(
                  'Selecionar data',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
  }
}
