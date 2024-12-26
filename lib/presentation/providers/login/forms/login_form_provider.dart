import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';

final loginFormProvider = StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});


class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email, error: "");
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, error: "");
  }

  Future<void> login() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(error: 'Por favor complete todos los campos');
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: '');
      await Future.delayed(const Duration(seconds: 2));
      //LLamada a la base de datos que permita el login de la app
      router.goNamed("quipux_saved");

    } catch (e) {
      state = state.copyWith(error: 'Error al iniciar sesión: ${e.toString()}');
      return;

    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

}


class LoginFormState {
  final String email;
  final String password;
  final bool isLoading;
  final String error;

  LoginFormState({
    this.email = "",
    this.password = "",
    this.isLoading = false,
    this.error = ""
  });

  LoginFormState copyWith({
   String? email,
   String? password,
   bool? isLoading,
   String? error
  }){
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }
}