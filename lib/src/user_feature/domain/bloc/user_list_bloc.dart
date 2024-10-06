import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/backend/remote/user_service.dart';
import '../../data/model/user.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final ApiService apiService; //locator
  int nextPage = 1;
  bool _hasMoreData = true;

  UserListBloc(this.apiService) : super(EmptyUserList()) {
    on<FetchUserList>(_onFetchUserList);
  }

  Future<void> _onFetchUserList(
      FetchUserList event, Emitter<UserListState> emit) async {
    if (state is LoadingUserList || !_hasMoreData) return;

    emit(LoadingUserList());

    try {
      final newUsers = await apiService.fetchUsers(event.page);
      if (newUsers.isEmpty) {
        _hasMoreData = false;
      } else {
        nextPage++;
        final users = state is LoadedUserList
            ? (state as LoadedUserList).users + newUsers
            : newUsers;
        emit(LoadedUserList(users, _hasMoreData));
      }
    } catch (e) {
      emit(UserListError('Failed to load users'));
    }
  }
}
