import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer_form.dart';
import 'package:bytebank/utils/strings.dart';
import 'package:flutter/material.dart';

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
        title: Text(titleAppBarTransferList),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          })).then((receiveTransfer) {
            _update(receiveTransfer);
          });
        },
      ),
    );
  }

  void _update(receiveTransfer) {
    if(receiveTransfer != null){
      setState(() {
        widget._transferList.add(receiveTransfer);
      });
    }
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
