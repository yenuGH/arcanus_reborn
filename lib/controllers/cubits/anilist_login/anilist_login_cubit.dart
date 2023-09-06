import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:oauth2_client/oauth2_helper.dart';

part 'anilist_login_state.dart';

class AnilistLoginCubit extends Cubit<AnilistLoginState> {
  AnilistLoginCubit() : super(AnilistLoginInitialState());

  void anilistLoginInitial() {
    emit(AnilistLoginInitialState());
  }

  void saveAnilistLogin() {
    print("Remember me has been checked");
    emit(AnilistLoginSavedState());
  }
  void notSaveAnilistLogin() {
    print("Remember me has been unchecked");
    emit(AnilistLoginNotSavedState());
  }

  void anilistLoginError() {
    emit(AnilistLoginErrorState());
  }

  void anilistLoginPressed() async {
    OAuth2Helper helper = AnilistClient().helper;
    try{
      await helper.getToken();
    } catch (e) {
      print("Error: $e");
      emit(AnilistLoginErrorState());
      return;
    }

    helper.getToken().then((token) {
      final tokenBox = Hive.box('userToken');
      tokenBox.put("token", token!.accessToken);
      print("Token: ${tokenBox.get("token")}");
    });

    emit(AnilistLoginPressedState());
  }
}
