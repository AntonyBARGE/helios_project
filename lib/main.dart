import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/user_feature/data/backend/remote/user_service.dart';
import 'src/user_feature/domain/bloc/user_list_bloc.dart';
import 'src/user_feature/presentation/user_list_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserListBloc(ApiService()),
      child: const MaterialApp(
        title: 'User List App',
        home: UserListPage(),
      ),
    ),
  );
}
