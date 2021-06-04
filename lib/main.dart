import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: TransferList(),
    ));
  }
}

class TransferList extends StatelessWidget {
  final List<Transfer> _transferList = [];

  @override
  Widget build(BuildContext context) {
    _transferList.add(Transfer(110.00, 4321));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferList.length,
        itemBuilder: (context, position) {
          return TransferItem(_transferList[position]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));
          future.then((receiveTransfer) {
            debugPrint('chegou no then do future');
            debugPrint('$receiveTransfer');
            _transferList.add(receiveTransfer);
          });
        },
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _controllerAccountNumber =
      TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            controllerField: _controllerAccountNumber,
            hint: '000000',
            label: 'Numero da Conta',
          ),
          Editor(
            controllerField: _controllerValue,
            label: 'Valor',
            hint: '0.00',
            icon: Icons.monetization_on,
          ),
          ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () {
                _createTransfer(context);
              })
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    double? value = double.tryParse(_controllerValue.text);
    int? accountNumber = int.tryParse(_controllerAccountNumber.text);

    if (_controllerAccountNumber != null && _controllerValue != null) {
      final createdTransfer = Transfer(value!, accountNumber!);
      Navigator.pop(context, createdTransfer);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controllerField;
  final String label;
  final String hint;
  final IconData? icon;

  Editor(
      {required this.controllerField,
      required this.label,
      required this.hint,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
        controller: controllerField,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transferência { valor: $value, numero da conta: $accountNumber}';
  }
}
