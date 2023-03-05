class User {
  final String name;
  final String phoneNumber;
  final String password;
  final List<String> addresses = [];

  User({
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  void addAddress(String address) {
    addresses.add(address);
  }
}
