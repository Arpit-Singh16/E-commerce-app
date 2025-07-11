import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adminusers extends StatefulWidget {
  const Adminusers({super.key});

  @override
  State<Adminusers> createState() => _AdminusersState();
}

class _AdminusersState extends State<Adminusers> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
<<<<<<< HEAD
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    fetchUsers();
=======

>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

<<<<<<< HEAD
  Future<void> fetchUsers() async {
    try {
      setState(() => isLoading = true);

      final snapshot =
      await FirebaseFirestore.instance.collection('users').get();

      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      setState(() {
        _users = users;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching users: $e");
      setState(() => isLoading = false);
    }
=======
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  Future<void> toggleBlockStatus(String userId, String currentStatus) async {
    final newStatus = currentStatus == 'Active' ? 'Blocked' : 'Active';
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'status': newStatus,
      });
<<<<<<< HEAD
      await fetchUsers(); // Refresh list
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User status updated to $newStatus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Future<void> deleteUser(String userId, String userName) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete $userName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).delete();
<<<<<<< HEAD
        await fetchUsers();
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User $userName deleted')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user: $e')),
        );
      }
    }
  }

<<<<<<< HEAD
  List<Map<String, dynamic>> get filteredUsers {
    if (_searchQuery.isEmpty) return _users;

    return _users.where((user) {
      final name = (user['username'] ?? '').toString().toLowerCase();
      final email = (user['email'] ?? '').toString().toLowerCase();
      return name.contains(_searchQuery) || email.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
=======
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text("Manage Users", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search users by name or email...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                ),
              ),
            ),
          ),
        ),
<<<<<<< HEAD
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchUsers,
        child: filteredUsers.isEmpty
            ? const Center(child: Text("No users found"))
            : ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: filteredUsers.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            final id = user['id'];
            final name = user['username'] ?? 'Unnamed';
            final email = user['email'] ?? '';
            final status = user['status'] ?? 'Active';
            final isAdmin = user['isAdmin'] ?? false;

            return ListTile(
              leading: const Icon(Icons.person, size: 40),
              title: Row(
                children: [
                  Text(name),
                  if (isAdmin)
                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "ADMIN",
                        style: TextStyle(
                            fontSize: 12, color: Colors.white),
                      ),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(email),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      color: status == 'Active'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      status == 'Active'
                          ? Icons.block
                          : Icons.check_circle,
                      color: status == 'Active'
                          ? Colors.red
                          : Colors.green,
                    ),
                    tooltip: status == 'Active'
                        ? 'Block User'
                        : 'Unblock User',
                    onPressed: () => toggleBlockStatus(id, status),
                  ),
                  IconButton(
                    icon:
                    const Icon(Icons.delete, color: Colors.grey),
                    tooltip: 'Delete User',
                    onPressed: () => deleteUser(id, name),
                  ),
                ],
              ),
=======
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('name', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final docs = snapshot.data?.docs ?? [];

            // Map docs to user data with id
            List<Map<String, dynamic>> users = docs
                .map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  data['id'] = doc.id;
                  return data;
                })
                .toList();

            // Filter locally by search query
            if (_searchQuery.isNotEmpty) {
              users = users.where((user) {
                final name = (user['name'] ?? '').toString().toLowerCase();
                final email = (user['email'] ?? '').toString().toLowerCase();
                return name.contains(_searchQuery) || email.contains(_searchQuery);
              }).toList();
            }

            if (users.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                final id = user['id'] ?? '';
                final name = user['name'] ?? 'Unnamed User';
                final email = user['email'] ?? '';
                final status = user['status'] ?? 'Active';

                return ListTile(
                  leading: const Icon(Icons.person, size: 40),
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email),
                      Text(
                        "Status: $status",
                        style: TextStyle(
                          color: status == 'Active' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          status == 'Active' ? Icons.block : Icons.check_circle,
                          color: status == 'Active' ? Colors.red : Colors.green,
                        ),
                        tooltip:
                            status == 'Active' ? 'Block User' : 'Activate User',
                        onPressed: () => toggleBlockStatus(id, status),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        tooltip: 'Delete User',
                        onPressed: () => deleteUser(id, name),
                      ),
                    ],
                  ),
                );
              },
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
            );
          },
        ),
      ),
    );
  }
}
