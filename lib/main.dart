import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.red[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red[900]
          ),
        )
      ),
        home: TransferList(),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transferList = [];

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<TransferList>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferList.length,
        itemBuilder: (context, position) {
          return TransferItem(widget._transferList[position]);
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
            if(receiveTransfer != null){
              setState(() {
                widget._transferList.add(receiveTransfer);
              });
            }
          });
        },
      ),
    );
  }
}

class TransferForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm>{

  final TextEditingController _controllerAccountNumber =
  TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final double? value = double.tryParse(_controllerValue.text);
    final int? accountNumber = int.tryParse(_controllerAccountNumber.text);

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
