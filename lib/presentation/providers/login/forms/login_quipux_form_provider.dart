
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/credential_quipux.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';
import 'package:tesis_firmonec/infrastructure/services/services.dart';

final loginQuipuxFormProvider = StateNotifierProvider<LoginQuipuxFormNotifier, LoginQuipuxFormState> ((ref) {
  return LoginQuipuxFormNotifier();
});



class LoginQuipuxFormNotifier extends StateNotifier<LoginQuipuxFormState> {
  LoginQuipuxFormNotifier() : super(LoginQuipuxFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email, error: "");
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, error: "");
  }

  void updateType(int type){
    state = state.copyWith(type: type);
  }


  Future<String?> loginQuipux() async {

    try {
      state = state.copyWith(isLoading: true);

      final authService = QuipuxAuthService();
      final token = await authService.login(
        email: state.email,
        password: state.password,
        type: state.type,
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );

      return token;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      return null;
    }

  }

}



class LoginQuipuxFormState {
  final String email;
  final String password;
  final int type;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  LoginQuipuxFormState({
    this.email = "",
    this.password = "",
    this.type = 0,
    this.isLoading = false,
    this.isSuccess = false,
    this.error = ""
  });

  LoginQuipuxFormState copyWith({
    String? email,
    String? password,
    int? type,
    bool? isLoading,
    bool? isSuccess,
    String? error
  }){
    return LoginQuipuxFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        type:  type ?? this.type,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        error: error ?? this.error
    );
  }
}