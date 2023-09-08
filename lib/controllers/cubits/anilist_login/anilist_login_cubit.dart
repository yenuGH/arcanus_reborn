import 'dart:developer';

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
    log("Remember me has been checked");
    emit(AnilistLoginSavedState());
  }
  void notSaveAnilistLogin() {
    log("Remember me has been unchecked");
    emit(AnilistLoginNotSavedState());
  }

  void anilistLoginError() {
    emit(AnilistLoginErrorState());
  }

  void anilistLoginPressedIOS() async {
    OAuth2Helper helper = AnilistClient().helper;
    try{
      await helper.getToken();
    } catch (e) {
      log("Error: $e");
      emit(AnilistLoginErrorState());
      return;
    }

    helper.getToken().then((token) {
      final tokenBox = Hive.box('userToken');
      tokenBox.put("token", token!.accessToken);
      log("Token: ${tokenBox.get("token")}");
    });

    emit(AnilistLoginPressedState());
  }

  void anilistLoginPressedAndroid(String? token) {
    if (token == null){
      emit(AnilistLoginErrorState());
      return;
    }

    final tokenBox = Hive.box('userToken');
    tokenBox.put("token", token);
    log("Token: ${tokenBox.get("token")}");
    emit(AnilistLoginPressedState());
  }

  void anilistLoginGrabToken () async {
    OAuth2Helper helper = AnilistClient().helper;
    try{
      await helper.getToken();
    } catch (e) {
      // the helper will return a null value on android
      // the user will manually paste their token
      return;
    }
  }
}
