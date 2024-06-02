class Profile {
  final String username;
  final String phone;
  final String displayName;
  final int experienceYears;
  final String address;
  final String level;

  Profile(
    this.username,
    this.phone,
    this.displayName,
    this.experienceYears,
    this.address,
    this.level,
  );

  factory Profile.fromJson(Map<String, dynamic> json) {
    print(json);
    return Profile(
        json['username'] ?? '',
        json['phone'] ?? '',
        json['displayName'] ?? '',
        json['experienceYears'],
        json['address'] ?? '', // Ensure the correct spelling from the JSON
        json['level'] ?? '');
  }
}
