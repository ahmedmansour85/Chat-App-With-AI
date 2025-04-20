import 'package:bloc/bloc.dart';
import 'package:chat_app_with_ai/core/helpers/auth_local_storge.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepo userRepo;

  SignupBloc({required this.userRepo}) : super(SignupInitial()) {
    on<SignupRequired>((event, emit) async {
      emit(SignupLoading());
      try {
        // أولاً، سجل المستخدم باستخدام `signUp`
        MyUser user = await userRepo.signUp(event.user, event.password);

        // تحقق إذا كان المستخدم موجودًا في جدول `users`
        bool userExists = await userRepo.checkIfUserExists(user.id);

        if (!userExists) {
          // إذا لم يكن موجودًا، استخدم `upsert` لإضافة أو تحديث البيانات
          await userRepo.createUser(user);
        } else {
          // إذا كان موجودًا، قم بتحديث بياناته إذا لزم الأمر
          await userRepo.updateUser(user);
        }
        final authStorage = AuthLocalStorage();
        await authStorage.setLoggedIn(true);

        emit(SignupSuccess());
      } catch (e) {
        emit(SignupError(error: e.toString()));
      }
    });
  }
}
