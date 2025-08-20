import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  // Patient data
  String profileImage =
      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80';
  String name = 'Sarah Johnson';
  String email = 'sarah.j@example.com';
  String phone = '+1 123 456 7890';
  String bio =
      'Patient with asthma and seasonal allergies. Currently managing symptoms with prescribed medication.';
  String bloodType = 'A+';
  String age = '42 years';
  String primaryDoctor = 'Dr. Michael Chen';
  String lastAppointment = 'Oct 15, 2023';
  String nextAppointment = 'Nov 20, 2023';
  String address = '123 Health St, Medical City';
  String emergencyContactName = 'David Johnson';
  String emergencyContactRelation = 'Husband';

  void _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          profileImage: profileImage,
          name: name,
          email: email,
          phone: phone,
          bio: bio,
          bloodType: bloodType,
          age: age,
          primaryDoctor: primaryDoctor,
          address: address,
          emergencyContactName: emergencyContactName,
          emergencyContactRelation: emergencyContactRelation,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        name = result['name'] ?? name;
        email = result['email'] ?? email;
        phone = result['phone'] ?? phone;
        bio = result['bio'] ?? bio;
        bloodType = result['bloodType'] ?? bloodType;
        age = result['age'] ?? age;
        primaryDoctor = result['primaryDoctor'] ?? primaryDoctor;
        address = result['address'] ?? address;
        emergencyContactName =
            result['emergencyContactName'] ?? emergencyContactName;
        emergencyContactRelation =
            result['emergencyContactRelation'] ?? emergencyContactRelation;
      });
      
      // Show a confirmation that changes were saved
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Profile Header with background
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Medical symbol in background
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: 0.05,
                      child: Icon(
                        Icons.medical_services,
                        size: 200,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  // Profile content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Picture with decoration
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Patient ID
                        Text(
                          'Patient ID: P-7284',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Medical Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(bloodType, 'Blood Type'),
                  _buildStatItem(age.split(' ')[0], 'Age'),
                  _buildStatItem('3', 'Conditions'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons for patient
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      label: Text(
                        'Schedule',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Patient Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Bio Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.medical_information,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Medical Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            bio,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contact Info Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoItem(Icons.phone, 'Phone', phone),
                          const Divider(),
                          _buildInfoItem(Icons.email, 'Email', email),
                          const Divider(),
                          _buildInfoItem(Icons.home, 'Address', address),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Medical Info Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoItem(
                            Icons.person,
                            'Primary Doctor',
                            primaryDoctor,
                          ),
                          const Divider(),
                          _buildInfoItem(
                            Icons.calendar_month,
                            'Last Appointment',
                            lastAppointment,
                          ),
                          const Divider(),
                          _buildInfoItem(
                            Icons.calendar_today,
                            'Next Appointment',
                            nextAppointment,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Emergency Contact Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Contact',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.emergency, color: Colors.white),
                            ),
                            title: Text(
                              emergencyContactName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(emergencyContactRelation),
                            trailing: TextButton(
                              onPressed: () {},
                              child: const Text('Call'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 24,
    );
  }
}

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  final String profileImage;
  final String name;
  final String email;
  final String phone;
  final String bio;
  final String bloodType;
  final String age;
  final String primaryDoctor;
  final String address;
  final String emergencyContactName;
  final String emergencyContactRelation;

  const EditProfileScreen({
    super.key,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.bloodType,
    required this.age,
    required this.primaryDoctor,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyContactRelation,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _ageController;
  late TextEditingController _primaryDoctorController;
  late TextEditingController _addressController;
  late TextEditingController _emergencyContactNameController;
  late TextEditingController _emergencyContactRelationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _bioController = TextEditingController(text: widget.bio);
    _bloodTypeController = TextEditingController(text: widget.bloodType);
    _ageController = TextEditingController(text: widget.age);
    _primaryDoctorController = TextEditingController(
      text: widget.primaryDoctor,
    );
    _addressController = TextEditingController(text: widget.address);
    _emergencyContactNameController = TextEditingController(
      text: widget.emergencyContactName,
    );
    _emergencyContactRelationController = TextEditingController(
      text: widget.emergencyContactRelation,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _bloodTypeController.dispose();
    _ageController.dispose();
    _primaryDoctorController.dispose();
    _addressController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactRelationController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      // Show error if required fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'bio': _bioController.text,
      'bloodType': _bloodTypeController.text,
      'age': _ageController.text,
      'primaryDoctor': _primaryDoctorController.text,
      'address': _addressController.text,
      'emergencyContactName': _emergencyContactNameController.text,
      'emergencyContactRelation': _emergencyContactRelationController.text,
    };

    Navigator.pop(context, updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveChanges),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Image
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.profileImage),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // Add image picker functionality here
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionHeader('Personal Information'),
            _buildTextField(_nameController, 'Full Name *', Icons.person),
            _buildTextField(_emailController, 'Email *', Icons.email),
            _buildTextField(_phoneController, 'Phone *', Icons.phone),
            _buildTextField(_addressController, 'Address', Icons.home),

            const SizedBox(height: 16),

            // Medical Information
            _buildSectionHeader('Medical Information'),
            _buildTextField(
              _bioController,
              'Medical Summary',
              Icons.medical_information,
              maxLines: 3,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _bloodTypeController,
                    'Blood Type',
                    Icons.bloodtype,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(_ageController, 'Age', Icons.cake),
                ),
              ],
            ),
            _buildTextField(
              _primaryDoctorController,
              'Primary Doctor',
              Icons.person,
            ),

            const SizedBox(height: 16),
            // Emergency Contact
            _buildSectionHeader('Emergency Contact'),
            _buildTextField(
              _emergencyContactNameController,
              'Emergency Contact Name',
              Icons.emergency,
            ),
            _buildTextField(
              _emergencyContactRelationController,
              'Relationship',
              Icons.group,
            ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Changes'),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maxLines: maxLines,
      ),
    );
  }
}