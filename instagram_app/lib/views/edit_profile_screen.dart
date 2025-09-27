import 'package:flutter/material.dart';
import 'edit_profile_item_screen.dart'; // Replace with actual edit screen paths

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save profile
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=8', // Random avatar image
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Edit Image",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildProfileRow(
              context: context,
              title: "Name",
              value: "Jacob West",
              onEditTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditNameScreen()),
                );
              },
            ),
            _buildProfileRow(
              context: context,
              title: "Username",
              value: "jacob_w",
              onEditTap: () {},
            ),
            _buildProfileRow(
              context: context,
              title: "Add Link",
              value: "Link",
              onEditTap: () {},
            ),
            _buildProfileRow(
              context: context,
              title: "Bio",
              value: "Digital goodies designer @pixsellz Everything",
              onEditTap: () {},
            ),
            _buildProfileRow(
              context: context,
              title: "Gender",
              value: "Male",
              onEditTap: () {},
            ),

            const SizedBox(height: 30),
            const Text(
              "Private Information",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoField(title: "Email", value: "jacob.west@gmail.com"),
            _buildInfoField(title: "Phone", value: "+1 202 555 0147"),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow({
    required BuildContext context,
    required String title,
    required String value,
    required VoidCallback onEditTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
            onPressed: onEditTap,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
