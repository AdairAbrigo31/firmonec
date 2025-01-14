import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'go_router.dart';

class MicrosoftID {
  static final Config config = Config(
    tenant: "b7af8caf-83d8-4644-85ae-317c545223c1",
    clientId: "c0c52924-3a1c-4d1d-9b63-7d08875207c8",
    scope: "openid profile email offline_access",
    redirectUri: "msauth://com.espol.firmonec2/callback",
    navigatorKey: navigatorKey,
    webUseRedirect: false, // Útil si también quieres soporte web
    loader: const Center(
        child: CircularProgressIndicator()), // Loader mientras se autentica
    // Para el postLogoutRedirectUri, dado que es una app móvil, podrías usar:
    postLogoutRedirectUri: "msauth://com.espol.firmonec2/callback",
    // responseType: 'id_token token'
  );
}
