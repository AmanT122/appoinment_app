import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _currentUserId;
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getCurrentLocation();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  void _getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
        _emailController.text = user.email ?? '';
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);

        setState(() {
          _locationController.text =
              "${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}";
        });
      } catch (e) {
        _showSnackBar('Could not fetch location. Please enter manually.');
      }
    } else {
      _showSnackBar('Location permission denied. Please enter manually.');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
if (image != null) {
  setState(() {
    _profileImage = File(image.path);
  });
}

  }

  Future<String?> _uploadImageWithRetry({int maxRetries = 3}) async {
    if (_profileImage == null) return null;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        attempt++;

        // Compress the image
        final dir = await getTemporaryDirectory();
        final targetPath = path.join(
          dir.path,
          'temp_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
          _profileImage!.absolute.path,
          targetPath,
          quality: 70,
        );

        if (compressedImage == null) throw Exception("Compression failed");

        final storageRef = FirebaseStorage.instanceFor(
                bucket: 'gs://appointment-sys-67b29.appspot.com')
            .ref()
            .child('patient_profile_images')
            .child('$_currentUserId-${DateTime.now().millisecondsSinceEpoch}.jpg');

        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'uploaded_by': _currentUserId ?? 'unknown'},
        );

        final File fileToUpload = File(compressedImage.path);
        final uploadTask = storageRef.putFile(fileToUpload, metadata);

        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            _uploadProgress = snapshot.bytesTransferred /
                snapshot.totalBytes.clamp(1, double.infinity);
          });
        });

        final TaskSnapshot snapshot = await uploadTask.timeout(
          const Duration(seconds: 30),
        );

        final String downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() => _isUploading = false);
        return downloadUrl;
      } catch (e) {
        if (attempt >= maxRetries) {
          setState(() => _isUploading = false);
          _showSnackBar('Upload failed after $maxRetries attempts: $e');
          return null;
        }

        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }
    return null;
  }

  void _retryUpload() {
    if (_profileImage != null) _uploadImageWithRetry();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      if (_profileImage != null) {
        imageUrl = await _uploadImageWithRetry();
        if (imageUrl == null) {
          setState(() => _isLoading = false);
          return;
        }
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserId)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'profileImage': imageUrl,
        'location': _locationController.text,
        'dateOfBirth': _dobController.text,
        'role': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      _showSnackBar('Profile saved successfully!');

      Navigator.pushReplacementNamed(context, '/patient_dashboard');
    } catch (e) {
      _showSnackBar('Error saving profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading && !_isUploading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage('assets/placeholder.png')
                                    as ImageProvider,
                            child: _profileImage == null
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                          if (_isUploading)
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: _uploadProgress,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                                onPressed: _isUploading ? null : _pickImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_isUploading) ...[
                      const SizedBox(height: 10),
                      LinearProgressIndicator(value: _uploadProgress),
                      const SizedBox(height: 5),
                      Text(
                        'Uploading: ${(_uploadProgress * 100).toStringAsFixed(1)}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                    const SizedBox(height: 20),

                    _buildTextField(_nameController, 'Full Name'),
                    const SizedBox(height: 16),

                    _buildTextField(_emailController, 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail),
                    const SizedBox(height: 16),

                    _buildTextField(_phoneController, 'Phone Number',
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),

                    _buildTextField(_addressController, 'Address', maxLines: 2),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _selectDate,
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Select DOB' : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location (Latitude, Longitude)',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.location_on),
                          onPressed: _getCurrentLocation,
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter location' : null,
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: (_isLoading || _isUploading) ? null : _submitForm,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save Profile'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
