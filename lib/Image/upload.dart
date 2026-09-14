import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});
  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  bool _loading = false;
  Future<void> _pickAndUpload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (_loading || user == null) return;
    setState(() => _loading = true);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      final bytes = await picked.readAsBytes();
      if (bytes.length > 10 * 1024 * 1024) {
        throw StateError('Choose an image smaller than 10 MB.');
      }
      final photo = FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .collection('photos')
          .doc();
      final storage = FirebaseStorage.instance.ref(
        'users/${user.uid}/images/${photo.id}',
      );
      final lower = picked.name.toLowerCase();
      final contentType =
          picked.mimeType ??
          (lower.endsWith('.png')
              ? 'image/png'
              : lower.endsWith('.webp')
              ? 'image/webp'
              : lower.endsWith('.gif')
              ? 'image/gif'
              : lower.endsWith('.heic')
              ? 'image/heic'
              : 'image/jpeg');
      await storage.putData(bytes, SettableMetadata(contentType: contentType));
      try {
        await photo.set({
          'url': await storage.getDownloadURL(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (_) {
        // Best effort cleanup if the metadata write fails after upload.
        try {
          await storage.delete();
        } catch (_) {}
        rethrow;
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Image uploaded.')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not upload. Check image size (10 MB maximum), permissions, and Firebase setup.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo upload experiment'),
        actions: [
          IconButton(
            tooltip: 'Upload photo',
            onPressed: _loading ? null : _pickAndUpload,
            icon: const Icon(Icons.upload),
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('Sign in to upload photos.'))
          : Column(
              children: [
                if (_loading) const LinearProgressIndicator(),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Photo upload demo. This does not update an account avatar.',
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(user.uid)
                        .collection('photos')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Unable to load photos.'),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No photos uploaded.'));
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                            ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final value = snapshot.data!.docs[index]
                              .data()['url'];
                          return Image.network(
                            value is String ? value : '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
