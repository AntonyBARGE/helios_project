part of 'user_list_bloc.dart';

sealed class UserListEvent {}

final class FetchUserList extends UserListEvent {
  final int page;
  FetchUserList(this.page);
}
