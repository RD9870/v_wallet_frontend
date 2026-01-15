import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/providers/transfer_history_provider.dart';
import 'package:v_wallet_frontend/widgets/clickables/transaction_tile.dart';

class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  @override
  void initState() {
    debugPrint("transfer history init state");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransferHistoryProvider>(
        context,
        listen: false,
      ).poplateHistory();
      Provider.of<TransferHistoryProvider>(context, listen: false).setLisnter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransferHistoryProvider>(
      builder: (context, historyConsumer, _) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Transfer History",
                    style: labelExtraLarge,
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      );
                      debugPrint("selectedDate: $selectedDate");
                      if (selectedDate != null) {
                        historyConsumer.handelFiltering(
                          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                        );
                      }
                    },
                    icon: Icon(Icons.tune, size: getSize(context).width * 0.08),
                  ),
                ],
              ),

              Expanded(
                child: historyConsumer.busy
                    ? Center(child: CircularProgressIndicator())
                    : historyConsumer.noData
                    ? Center(child: Text("Sorry no data to show here"))
                    : ListView.builder(
                        controller: historyConsumer.controller,
                        itemCount: historyConsumer.transferHistory.length + 1,
                        itemBuilder: (context, index) {
                          if (index < historyConsumer.transferHistory.length) {
                            final transfer =
                                historyConsumer.transferHistory[index];
                            return TransactionTile(
                              amount: transfer.amount,
                              date: transfer.date,
                              type: transfer.transactionType,
                            );
                          } else {
                            return historyConsumer.isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: primaryColor,
                                          strokeWidth: 2.5,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
