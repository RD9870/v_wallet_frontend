import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/screens/transfer/transfer_amount_screen.dart';
import 'package:v_wallet_frontend/widgets/dialogs/show_add_popup.dart';
import '../../providers/beneficiary_provider.dart';
import '../../widgets/transfer/add_beneficiary.dart';
import '../../widgets/transfer/beneficiary_card.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => BeneficiariesScreenState();
}

class BeneficiariesScreenState extends State<BeneficiariesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<BeneficiaryProvider>().fetchBeneficiaries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "To Start Transaction please\nEnter the Receiver Phone\nnumber",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextField(
                    controller: provider.manualPhoneController,
                    keyboardType: TextInputType.phone,
                    enabled: !provider.isValidating,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      await provider.navigateToTransfer(value);
                      debugPrint("onSubmitted Error: ${provider.errorMessage}");

                      if (provider.errorMessage != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(provider.errorMessage!),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (provider.errorMessage == null &&
                          context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please input the ammount")),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferAmountScreen(
                              receiverPhone: provider.cleanPhone,
                            ),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.phone, color: Colors.black),

                      suffixIcon: provider.isValidating
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () async {
                                await provider.navigateToTransfer(
                                  provider.manualPhoneController.text,
                                );
                                debugPrint(
                                  "onSubmitted Error: ${provider.errorMessage}",
                                );

                                if (provider.errorMessage != null &&
                                    context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(provider.errorMessage!),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (provider.errorMessage == null &&
                                    context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please input the ammount"),
                                    ),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransferAmountScreen(
                                            receiverPhone: provider.cleanPhone,
                                          ),
                                    ),
                                  );
                                }
                              },
                            ),

                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Or Select a Benficiary Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ShowAddPopup(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: provider.busy
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: provider.beneficiariess.length,
                            padding: const EdgeInsets.only(top: 10),
                            itemBuilder: (context, index) {
                              final b = provider.beneficiariess[index];
                              return BeneficiaryCard(
                                name: b.name,
                                phone: b.phone,
                                onDelete: () =>
                                    provider.deleteBeneficiary(b.beneficiaryId),
                                onTap: () async {
                                  await provider.navigateToTransfer(b.phone);
                                  debugPrint(
                                    "onSubmitted Error: ${provider.errorMessage}",
                                  );

                                  if (provider.errorMessage != null &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(provider.errorMessage!),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (provider.errorMessage == null &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Please input the ammount",
                                        ),
                                      ),
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransferAmountScreen(
                                              receiverPhone:
                                                  provider.cleanPhone,
                                            ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
