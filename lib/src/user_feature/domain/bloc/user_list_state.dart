part of 'user_list_bloc.dart';

sealed class UserListState {}

final class EmptyUserList extends UserListState {}

final class LoadingUserList extends UserListState {}

final class LoadedUserList extends UserListState {
  final List<User> users;
  final bool hasMoreData;

  LoadedUserList(this.users, this.hasMoreData);
}

final class UserListError extends UserListState {
  final String message;

  UserListError(this.message);
}
