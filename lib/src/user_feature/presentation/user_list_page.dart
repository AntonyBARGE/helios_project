import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/user.dart';
import '../domain/bloc/user_list_bloc.dart';
import 'user_details_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  List<User> _fullUserList = [];
  List<User> _filteredUserList = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<UserListBloc>().add(FetchUserList(1));
  }

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredUserList = _fullUserList;
      } else {
        _filteredUserList = _fullUserList
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                _filterUsers(query);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is LoadingUserList) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListError) {
            return Center(child: Text(state.message));
          } else if (state is LoadedUserList) {
            if (_fullUserList.isEmpty || _searchQuery.isEmpty) {
              _fullUserList = state.users;
              _filteredUserList = _fullUserList;
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredUserList.length,
                    itemBuilder: (context, index) {
                      final user = _filteredUserList[index];
                      return ListTile(
                        leading: Image.network(user.pictureUrl),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsPage(user: user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child:
                      Text('Page ${context.read<UserListBloc>().nextPage - 1}'),
                ),
                if (state.hasMoreData)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<UserListBloc>().add(FetchUserList(
                            context.read<UserListBloc>().nextPage));
                      },
                      child: const Text('Load More'),
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: Text('No users found.'));
          }
        },
      ),
    );
  }
}
