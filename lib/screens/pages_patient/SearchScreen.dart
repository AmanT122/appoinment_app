import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  // Sample data for search results
  final List<Map<String, dynamic>> _recentSearches = [
    {'name': 'Dr. Sarah Johnson', 'type': 'Cardiologist', 'time': '2 hours ago'},
    {'name': 'Blood Test', 'type': 'Lab Test', 'time': 'Yesterday'},
    {'name': 'Physical Therapy', 'type': 'Treatment', 'time': '2 days ago'},
  ];
  
  final List<Map<String, dynamic>> _popularSearches = [
    {'name': 'Dr. Michael Chen', 'specialty': 'Neurology', 'rating': 4.8, 'reviews': 124},
    {'name': 'MRI Scan', 'type': 'Diagnostic', 'category': 'Imaging'},
    {'name': 'Diabetes Management', 'type': 'Program', 'category': 'Chronic Care'},
    {'name': 'Dr. Emily Rodriguez', 'specialty': 'Pediatrics', 'rating': 4.9, 'reviews': 98},
    {'name': 'Annual Checkup', 'type': 'Service', 'category': 'Preventive Care'},
  ];
  
  final List<Map<String, dynamic>> _quickCategories = [
    {'icon': Icons.medical_services, 'title': 'Doctors', 'color': Colors.blue},
    {'icon': Icons.local_hospital, 'title': 'Hospitals', 'color': Colors.red},
    {'icon': Icons.medication, 'title': 'Medicines', 'color': Colors.green},
    {'icon': Icons.health_and_safety, 'title': 'Labs', 'color': Colors.orange},
  ];
  
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }
    
    setState(() {
      _isSearching = true;
      // Simulate search results
      _searchResults = _popularSearches.where((item) {
        return item['name'].toLowerCase().contains(query.toLowerCase()) ||
               (item['specialty'] != null && item['specialty'].toLowerCase().contains(query.toLowerCase())) ||
               (item['type'] != null && item['type'].toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
      _searchResults = [];
      _searchFocusNode.unfocus();
    });
  }

  Widget _buildSearchBox() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'Search doctors, hospitals, medicines...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildQuickCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Quick Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _quickCategories.length,
            itemBuilder: (context, index) {
              final category = _quickCategories[index];
              return Container(
                width: 90,
                margin: const EdgeInsets.only(right: 12),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      // Handle category tap
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'], size: 30, color: category['color']),
                        const SizedBox(height: 8),
                        Text(
                          category['title'],
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Recent Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentSearches.length,
          itemBuilder: (context, index) {
            final search = _recentSearches[index];
            return ListTile(
              leading: const Icon(Icons.history, color: Colors.grey),
              title: Text(search['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text("${search['type']} • ${search['time']}"),
              trailing: IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  // Remove from recent searches
                },
              ),
              onTap: () {
                _searchController.text = search['name'];
                _performSearch(search['name']);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Popular Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _popularSearches.map((item) {
            return Chip(
              backgroundColor: Colors.grey[100],
              label: Text(item['name']),
              onDeleted: () {
                // Handle chip deletion if needed
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('No results found', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                result['specialty'] != null ? Icons.person : Icons.medical_services,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(result['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: result['specialty'] != null
                ? Text("${result['specialty']} • ⭐ ${result['rating']} (${result['reviews']} reviews)")
                : Text("${result['type']} • ${result['category']}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Handle result tap
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          _buildSearchBox(),
          Expanded(
            child: _isSearching
                ? _buildSearchResults()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildQuickCategories(),
                        const SizedBox(height: 20),
                        _buildRecentSearches(),
                        const SizedBox(height: 20),
                        _buildPopularSearches(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}