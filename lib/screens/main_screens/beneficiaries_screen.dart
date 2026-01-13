import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/widgets/add_beneficiary.dart';
import 'package:v_wallet_frontend/widgets/beneficiary_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  final List<Map<String, String>> beneficiaries = [
    {"name": "Sara Ali Khaled", "phone": "0914839201"},
    {"name": "Asma Ahmed", "phone": "0927294678"},
    {"name": "Naser Basheer", "phone": "09193750248"},
    {"name": "Khaled Sameer", "phone": "0928529528"},
  ];
  int currentIndex = 2;
  final List<String> iconAssets = [
    "assets/icons/wallet.svg",
    "assets/icons/home.svg",
    "assets/icons/transfer.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "To Start Transaction please\nEnter the Receiver Phone number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Or Select a Beneficiary Account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddBeneficiaryPopup(
                            onAdd: (name, phone) {
                              setState(() {
                                beneficiaries.add({
                                  "name": name,
                                  "phone": phone,
                                });
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: beneficiaries.length,
                  itemBuilder: (context, index) {
                    final beneficiary = beneficiaries[index];
                    return BeneficiaryCard(
                      name: beneficiary["name"]!,
                      phone: beneficiary["phone"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: List.generate(iconAssets.length, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              iconAssets[index],
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                currentIndex == index
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.grey.shade400,
                BlendMode.srcIn,
              ),
            ),
            label: "",
          );
        }),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
