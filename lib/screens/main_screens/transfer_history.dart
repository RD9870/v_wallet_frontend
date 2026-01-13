import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/providers/transfer_history_provider.dart';
import 'package:v_wallet_frontend/widgets/clickables/transaction_tile.dart';

class TransferHistory extends StatelessWidget {
  const TransferHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransferHistoryProvider>(builder: (context, historyConsumer, _) {
      return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text("Transfer History", style: labelExtraLarge, textAlign: TextAlign.center,),
            IconButton(onPressed: () async{
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                initialEntryMode: DatePickerEntryMode.calendarOnly
              );
                debugPrint("selectedDate: $selectedDate");
                if(selectedDate != null){
                historyConsumer.handelFiltering(selectedDate);
                }
            }, icon: Icon(Icons.tune, size: getSize(context).width*0.08,))
          ],),

          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return TransactionTile(
                  amount: 333,
                  date: "12 july 1959",
                  type: TransactionType.transfered,
                );
              },
            ),
          ),
        ],
      ),
    );
    },);
  }
}