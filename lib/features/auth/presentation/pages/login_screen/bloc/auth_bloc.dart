import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/usecases/sensitive_data/admin_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // on<AuthEvent>((event, emit) {});

    on<LoginEvent>(
      (event, emit) {
        var v = login(event.adminid, event.password);
        if (v == true) {
          saveUserId(event.adminid);
          emit(AuthenticationSuccessState());
        } else {
          emit(AuthenticationErrorState());
        }
      },
    );
  }
}

bool login(String adminid, String password) {
  if (adminid == admin && password == adminpassword) {
    return true;
  } else {
    return false;
  }
}

Future<void> saveUserId(String userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_id', userId);
}
