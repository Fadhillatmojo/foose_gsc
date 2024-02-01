import 'package:bloc/bloc.dart';
import 'package:foose_gsc/bloc/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignUpRequested>((event, state) async {
      emit(Loading());
      try {
        authRepository.signUp(email: event.email, password: event.password);
      } catch (e) {
        emit(UnAuthenticated());
      }
    });
  }
}
