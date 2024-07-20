class Collegiate {
  final String address;
  final String birthdate;
  final String code;
  final String email;
  final String gender;
  final int id;
  final String member;
  final int phone;
  final bool status;

  Collegiate({
    required this.address,
    required this.birthdate,
    required this.code,
    required this.email,
    required this.gender,
    required this.id,
    required this.member,
    required this.phone,
    required this.status,
  });

  factory Collegiate.fromMap(Map<String, dynamic> data) {
    return Collegiate(
      address: data['Address'] ?? '',
      birthdate: data['Birthdate'] ?? '',
      code: data['Code'] ?? '',
      email: data['Email'] ?? '',
      gender: data['Gender'] ?? '',
      id: data['ID'] ?? '',
      member: data['Member'] ?? '',
      phone: data['Phone'] ?? '',
      status: data['Status'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Address': address,
      'Birthdate': birthdate,
      'Code': code,
      'Email': email,
      'Gender': gender,
      'ID': id,
      'Member': member,
      'Phone': phone,
      'status': status,
    };
  }
}
