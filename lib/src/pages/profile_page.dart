import 'package:tasky/src/components/common/info_text.dart';
import 'package:tasky/src/components/common/phone_info.dart';
import 'package:tasky/src/components/layouts/page_layout.dart';
import 'package:tasky/src/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:tasky/src/services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data available'));
          } else {
            final profile = snapshot.data!;
            return PageLayout(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoText(label: 'Name', value: profile.displayName),
                    PhoneInfo(profile.username),
                    InfoText(label: 'Level', value: profile.level),
                    InfoText(
                      label: 'Years of Experience',
                      value: "${profile.experienceYears} Years",
                    ),
                    InfoText(label: 'Location', value: profile.address),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
