class Beneficiary {
  final int id;
  final int beneficiaryId;
  final String name;
  final String phone;

  Beneficiary({
    required this.id,
    required this.beneficiaryId,
    required this.name,
    required this.phone,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    final userPart = json['beneficiary'] as Map<String, dynamic>?;

    return Beneficiary(
      id: json['id'],
      beneficiaryId: json['beneficiary_id'],
      name: userPart?['name'] ?? 'Unknown',
      phone: userPart?['phone'] ?? 'No Phone',
    );
  }
}
