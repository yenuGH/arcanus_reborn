import 'dart:io';

import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class AnilistOAuthClient extends OAuth2Client {
  AnilistOAuthClient({
    required String redirectUri,
    required String customUriScheme,
  }) : super(
          authorizeUrl: 'https://anilist.co/api/v2/oauth/authorize',
          tokenUrl: 'https://anilist.co/api/v2/oauth/token',
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
        );
}

OAuth2Helper createAnilistOAuthHelper() {
  late String clientId;
  if (Platform.isAndroid) {
    clientId = '14331';
  } else if (Platform.isIOS) {
    clientId = '14371';
  } else {
    throw UnsupportedError('Unsupported platform');
  }


  AnilistOAuthClient anilistOAuthClient = AnilistOAuthClient(
    customUriScheme: "com.arcanus.app", 
    //redirectUri: "",
    redirectUri: "",
  );

  return OAuth2Helper(
    anilistOAuthClient,
    grantType: OAuth2Helper.implicitGrant,
    clientId: clientId,
  );
}