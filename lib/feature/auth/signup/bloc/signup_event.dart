part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupRequired extends SignupEvent {
  final MyUser user;
  final String password;

  const SignupRequired({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}
