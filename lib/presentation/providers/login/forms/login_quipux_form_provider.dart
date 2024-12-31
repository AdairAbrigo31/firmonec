
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginQuipuxFormProvider = StateNotifierProvider<LoginQuipuxFormNotifier, LoginQuipuxFormState> ((ref) {
  return LoginQuipuxFormNotifier();
});



class LoginQuipuxFormNotifier extends StateNotifier<LoginQuipuxFormState> {
  LoginQuipuxFormNotifier() : super(LoginQuipuxFormState());

  void updateType(int type){
    state = state.copyWith(type: type);
  }

}



class LoginQuipuxFormState {
  final int type;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  LoginQuipuxFormState({
    this.type = 0,
    this.isLoading = false,
    this.isSuccess = false,
    this.error = ""
  });

  LoginQuipuxFormState copyWith({
    int? type,
    bool? isLoading,
    bool? isSuccess,
    String? error
  }){
    return LoginQuipuxFormState(
        type:  type ?? this.type,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        error: error ?? this.error
    );
  }
}