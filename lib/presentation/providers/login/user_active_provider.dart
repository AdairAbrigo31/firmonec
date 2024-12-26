import 'package:flutter_riverpod/flutter_riverpod.dart';

final userActiveProvider = StateNotifierProvider<UserActiveNotifier, UserActiveState>((ref) {
  return UserActiveNotifier(
      UserActiveState()
  );
});

class UserActiveNotifier extends StateNotifier<UserActiveState> {
  UserActiveNotifier(super.state);

  // Actualizar usuario completo
  void updateUser({
    String? email,
    String? password,
    String? token,
    String? id,
  }) {
    state = state.copyWith(
      email: email,
      password: password,
      token: token,
      id: id,
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateToken(String token) {
    state = state.copyWith(token: token);
  }

  void updateId(String id) {
    state = state.copyWith(id: id);
  }

  void clearUser() {
    state = UserActiveState();
  }

  // Verificar si hay un usuario activo
  bool get hasActiveUser => state.email != null && state.token != null;
}

class UserActiveState {
  final String? email;
  final String? password;
  final String? token;
  final String? id;

  UserActiveState({
    this.email,
    this.password,
    this.token,
    this.id
  });

  UserActiveState copyWith({
    String? email,
    String? password,
    String? token,
    String? id,
  }) {
    return UserActiveState(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }
}