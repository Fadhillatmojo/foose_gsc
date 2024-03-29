import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
