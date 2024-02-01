// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // Events
// abstract class AuthEvent {}

// class SignInEvent extends AuthEvent {
//   final String email;
//   final String password;

//   SignInEvent({required this.email, required this.password});
// }

// // States
// abstract class AuthState {}

// class AuthInitialState extends AuthState {}

// class AuthLoadingState extends AuthState {}

// class AuthSuccessState extends AuthState {
//   final User user;

//   AuthSuccessState({required this.user});
// }

// class AuthErrorState extends AuthState {
//   final String error;

//   AuthErrorState({required this.error});
// }

// // BLoC
// // class AuthBloc extends Bloc<AuthEvent, AuthState> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   AuthBloc() : super(AuthInitialState());
// //   @override
// //   Stream<AuthState> mapEventToState(AuthEvent event) async* {
// //     if (event is SignInEvent) {
// //       yield AuthLoadingState();

// //       try {
// //         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //           email: event.email,
// //           password: event.password,
// //         );

// //         yield AuthSuccessState(user: userCredential.user!);
// //       } catch (e) {
// //         yield AuthErrorState(error: e.toString());
// //       }
// //     }
// //   }
// // }

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<AuthEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String email, required String password}) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code === 'weak-password') {
        throw Exception('This Password is Too Weak');
      } else if (e.code === 'email-already-in-use') {
        throw Exception('The account already used');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
