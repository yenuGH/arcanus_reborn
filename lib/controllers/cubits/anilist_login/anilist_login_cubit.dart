import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oauth2_client/oauth2_helper.dart';

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

    OAuth2Helper helper = AnilistClient().helper;
    helper.fetchToken();

    emit(AnilistLoginPressedState());
  }
}
