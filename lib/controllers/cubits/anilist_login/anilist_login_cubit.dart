import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anilist_login_state.dart';

class AnilistLoginCubit extends Cubit<AnilistLoginState> {
  AnilistLoginCubit() : super(AnilistLoginInitialState());

  void saveAnilistLogin() {
    print("Remember me has been checked");
    emit(AnilistLoginSavedState());
  }
  void notSaveAnilistLogin() {
    print("Remember me has been unchecked");
    emit(AnilistLoginNotSavedState());
  }

  void anilistLoginPressed(String email, String password) {
    final String anilistEmail = email;
    final String anilistPassword = password;

    print("Email: $anilistEmail\nPassword: $anilistPassword");

    emit(AnilistLoginPressedState());
  }
}
