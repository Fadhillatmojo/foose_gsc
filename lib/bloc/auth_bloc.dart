import 'package:bloc/bloc.dart';
import 'package:foose_gsc/bloc/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignUpRequested>((event, state) async {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(Loading());
      try {
        authRepository.signUp(email: event.email, password: event.password);
      } catch (e) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(UnAuthenticated());
      }
    });
  }
}
