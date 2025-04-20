import 'package:bloc/bloc.dart';
import 'package:chat_app_with_ai/core/helpers/auth_local_storge.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepo userRepo;

  SigninBloc({required this.userRepo}) : super(SigninInitial()) {
    on<SigninRequred>((event, emit) async {
      emit(SigninLoading());
      try {
        await userRepo.signIn(event.email, event.password);
        final authStorage = AuthLocalStorage();
        await authStorage.setLoggedIn(true);
        emit(SigninSuccess());
      } catch (e) {
        emit(SigninError());
      }
    });

    on<SignoutRequred>((event, emit) async {
      await userRepo.signOut();
      emit(SignoutSuccess());
    });
  }
}
