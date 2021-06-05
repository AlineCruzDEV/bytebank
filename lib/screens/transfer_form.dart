import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/utils/strings.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccountNumber =
  TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBarTransferForm),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controllerField: _controllerAccountNumber,
              hint: hintAccountNumber,
              label: labelAccountNumber,
            ),
            Editor(
              controllerField: _controllerValue,
              label: labelValue,
              hint: hintValue,
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
                child: Text(textConfirmButton),
                onPressed: () {
                  _createTransfer(context);
                }),
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final double? value = double.tryParse(_controllerValue.text);
    final int? accountNumber = int.tryParse(_controllerAccountNumber.text);

    final createdTransfer = Transfer(value!, accountNumber!);
    Navigator.pop(context, createdTransfer);
  }
}
