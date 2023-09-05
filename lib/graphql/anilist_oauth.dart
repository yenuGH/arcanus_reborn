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
  AnilistOAuthClient anilistOAuthClient = AnilistOAuthClient(
    customUriScheme: "arcanus", 
    redirectUri: "",
  );

  return OAuth2Helper(
    anilistOAuthClient,
    grantType: OAuth2Helper.implicitGrant,
    clientId: '14331',
  );
}