import 'dart:io';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.imagePath, required this.size});

  final String? imagePath;
  final double size;

  static const _placeholder = 'assets/images/userProfile.png';

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    final ImageProvider image = path == null || path.isEmpty
        ? const AssetImage(_placeholder)
        : path.startsWith('/')
        ? FileImage(File(path))
        : AssetImage('assets/images/$path');

    return ClipOval(
      child: Image(
        image: image,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Icon(Icons.account_circle, size: size),
      ),
    );
  }
}
