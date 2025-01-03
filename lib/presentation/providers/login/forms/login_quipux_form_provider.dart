
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginQuipuxFormProvider = StateNotifierProvider<LoginQuipuxFormNotifier, LoginQuipuxFormState> ((ref) {
  return LoginQuipuxFormNotifier();
});



class LoginQuipuxFormNotifier extends StateNotifier<LoginQuipuxFormState> {
  LoginQuipuxFormNotifier() : super(LoginQuipuxFormState());

  void updateType(int type){
    state = state.copyWith(type: type);
  }

  void updateMail(String mail){
    state = state.copyWith(mail: mail);
  }

}



class LoginQuipuxFormState {
  final String? mail;
  final int type;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  LoginQuipuxFormState({
    this.mail,
    this.type = 0,
    this.isLoading = false,
    this.isSuccess = false,
    this.error = ""
  });

  LoginQuipuxFormState copyWith({
    String? mail,
    int? type,
    bool? isLoading,
    bool? isSuccess,
    String? error
  }){
    return LoginQuipuxFormState(
      mail: mail ?? this.mail,
        type:  type ?? this.type,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        error: error ?? this.error
    );
  }
}