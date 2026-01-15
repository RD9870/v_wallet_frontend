import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/widgets/bank_card.dart';
import 'top_up_details_screen.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  final List<Map<String, dynamic>> banks = const [
    {
      'id': 1,
      'name': 'Bank of Commerce & Development',
      'logo': 'assets/tegara.png',
    },
    {'id': 2, 'name': 'Mediterranean Bank', 'logo': 'assets/mid.png'},
    {'id': 3, 'name': 'Wahada Bank', 'logo': 'assets/whada.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top UP")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your bank",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...banks.map((bank) {
              return BankCard(
                bankName: bank['name'],
                logoPath: bank['logo'],
                isSelected: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TopUpDetailsScreen(
                        bankId: bank['id'],
                        bankName: bank['name'],
                        logoPath: bank['logo'],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
