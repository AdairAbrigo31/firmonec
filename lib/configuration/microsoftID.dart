import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'go_router.dart';


class MicrosoftID {
  static final Config config = Config(
    tenant: "b7af8caf-83d8-4644-85ae-317c545223c1",
    clientId: "0af9f71a-8fd1-4b58-920b-25fb4aff687b",
    scope: "openid profile offline_access",
    redirectUri: "msauth://com.espol.firmonec/callback",
    navigatorKey: navigatorKey,
    webUseRedirect: false, // Útil si también quieres soporte web
    loader: const Center(child: CircularProgressIndicator()), // Loader mientras se autentica
    // Para el postLogoutRedirectUri, dado que es una app móvil, podrías usar:
    postLogoutRedirectUri: "msauth://com.espol.firmonec/callback",
  );
}