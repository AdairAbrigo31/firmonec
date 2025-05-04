import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'go_router.dart';

class MicrosoftID {
  static final String tenant = dotenv.env["TENANT_ID"] ?? "";
  static final String clientId = dotenv.env["CLIENT_ID"] ?? "";

  static final Config config = Config(
    tenant: tenant,
    clientId: clientId,
    scope: "openid profile email offline_access",
    redirectUri: "msauth://com.espol.firmonec2/callback",
    navigatorKey: navigatorKey,
    webUseRedirect: false, // Útil si también quieres soporte web
    loader: const Center(
        child: CircularProgressIndicator()), // Loader mientras se autentica
    // Para el postLogoutRedirectUri, dado que es una app móvil, podrías usar:
    postLogoutRedirectUri: "msauth://com.espol.firmonec2/callback",
  );
}
