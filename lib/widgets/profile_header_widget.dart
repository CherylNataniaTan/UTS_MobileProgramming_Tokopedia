import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String username;
  final String? imageUrl;
  final VoidCallback onEditProfile;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.username,
    this.imageUrl,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
              child: !hasImage
                  ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.from(
                          alpha: 1,
                          red: 0.439,
                          green: 0.051,
                          blue: 0.106,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(username, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 112, 13, 27),
              ),
              onPressed: onEditProfile,
            ),
          ],
        ),
      ),
    );
  }
}
