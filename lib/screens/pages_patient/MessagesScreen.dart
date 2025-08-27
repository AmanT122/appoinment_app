import 'package:flutter/material.dart';

// Doctor Profile Screen
class DoctorProfileScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctor['image']),
              radius: 60,
            ),
            const SizedBox(height: 16),
            Text(
              doctor['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              doctor['specialty'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(context),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(Icons.work_outline, 'Experience', '12 years'),
            const Divider(),
            _buildInfoRow(Icons.school, 'Education', 'MD, Harvard Medical School'),
            const Divider(),
            _buildInfoRow(Icons.star, 'Rating', '4.9 (248 reviews)'),
            const Divider(),
            _buildInfoRow(Icons.language, 'Languages', 'English, Spanish'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Call functionality
            },
            icon: const Icon(Icons.call),
            label: const Text('Call'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Book appointment functionality
            },
            icon: const Icon(Icons.calendar_today),
            label: const Text('Book Appointment'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Main Messaging Screen
class Messagesscreen extends StatefulWidget {
  const Messagesscreen({super.key});

  @override
  State<Messagesscreen> createState() => _MessagesscreenState();
}

class _MessagesscreenState extends State<Messagesscreen> {
  final List<Map<String, dynamic>> _doctors = [
    {
      'id': '1',
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'lastMessage': 'Hello! How are you feeling today?',
      'time': '10:30 AM',
      'unread': 2,
      'messages': [
        {
          'text': 'Hello there! How are you doing today?',
          'isMe': false,
          'time': '10:30 AM',
        },
        {
          'text': "I'm doing great! Just working on this new app.",
          'isMe': true,
          'time': '10:32 AM',
        },
        {
          'text': 'That sounds interesting. What kind of app is it?',
          'isMe': false,
          'time': '10:33 AM',
        },
      ],
    },
    {
      'id': '2',
      'name': 'Dr. Michael Chen',
      'specialty': 'Neurologist',
      'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'lastMessage': 'Your test results are ready',
      'time': 'Yesterday',
      'unread': 0,
      'messages': [
        {
          'text': 'Your MRI results are back.',
          'isMe': false,
          'time': 'Yesterday',
        },
        {
          'text': "When can I come in to discuss them?",
          'isMe': true,
          'time': 'Yesterday',
        },
      ],
    },
    {
      'id': '3',
      'name': 'Dr. Emily Rodriguez',
      'specialty': 'Dermatologist',
      'image': 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'lastMessage': 'The medication seems to be working well',
      'time': '2 days ago',
      'unread': 5,
      'messages': [
        {
          'text': 'The rash seems to be improving with the new cream.',
          'isMe': false,
          'time': '2 days ago',
        },
      ],
    },
    {
      'id': '4',
      'name': 'Dr. James Wilson',
      'specialty': 'Orthopedist',
      'image': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'lastMessage': 'Let\'s schedule a follow-up appointment',
      'time': '1 week ago',
      'unread': 0,
      'messages': [
        {
          'text': 'Your physical therapy is going well.',
          'isMe': false,
          'time': '1 week ago',
        },
        {
          'text': "That's great to hear! When should I come back?",
          'isMe': true,
          'time': '1 week ago',
        },
        {
          'text': 'Let\'s schedule a follow-up in two weeks.',
          'isMe': false,
          'time': '1 week ago',
        },
      ],
    },
  ];
  
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  Map<String, dynamic>? _selectedDoctor;
  bool _showChatScreen = false;

  void _selectDoctor(Map<String, dynamic> doctor) {
    setState(() {
      _selectedDoctor = {...doctor}; // Create a copy to avoid direct mutation
      _showChatScreen = true;
    });
  }

  void _goBackToDoctors() {
    setState(() {
      _showChatScreen = false;
      _selectedDoctor = null;
    });
  }

  void _openDoctorProfile() {
    if (_selectedDoctor != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorProfileScreen(doctor: _selectedDoctor!),
        ),
      );
    }
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      // Create a new message object
      final newMessage = {
        'text': _controller.text,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      };

      // Add message to the selected doctor's message list
      if (_selectedDoctor != null) {
        _selectedDoctor!['messages'] = [..._selectedDoctor!['messages'], newMessage];
        
        // Also update the message in the main doctors list
        final doctorIndex = _doctors.indexWhere((doc) => doc['id'] == _selectedDoctor!['id']);
        if (doctorIndex != -1) {
          _doctors[doctorIndex]['messages'] = [..._doctors[doctorIndex]['messages'], newMessage];
          
          // Update last message and time
          _doctors[doctorIndex]['lastMessage'] = _controller.text;
          _doctors[doctorIndex]['time'] = 'Just now';
        }
      }
    });

    _controller.clear();

    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            GestureDetector(
              onTap: _openDoctorProfile,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(_selectedDoctor?['image'] ?? ''),
                radius: 16,
              ),
            ),
          if (!isMe) const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isMe 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'],
                    style: TextStyle(
                      fontSize: 16,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['time'],
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 8),
          if (isMe)
            const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList() {
    return ListView.builder(
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(doctor['image']),
            radius: 25,
          ),
          title: Text(
            doctor['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            doctor['specialty'] ?? doctor['specialty'],
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                doctor['time'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
              if (doctor['unread'] > 0)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    doctor['unread'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () => _selectDoctor(doctor),
        );
      },
    );
  }

  Widget _buildChatScreen() {
    final messages = _selectedDoctor?['messages'] ?? [];
    
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.emoji_emotions_outlined,
                              color: Theme.of(context).colorScheme.primary),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showChatScreen
            ? GestureDetector(
                onTap: _openDoctorProfile,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_selectedDoctor?['image'] ?? ''),
                      radius: 16,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedDoctor?['name'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          _selectedDoctor?['specialty'] ?? _selectedDoctor?['specialty'] ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const Text('Messages'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 1,
        leading: _showChatScreen
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goBackToDoctors,
              )
            : null,
        actions: _showChatScreen
            ? [
                IconButton(
                  icon: const Icon(Icons.video_call),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
      ),
      body: _showChatScreen ? _buildChatScreen() : _buildDoctorsList(),
    );
  }
}