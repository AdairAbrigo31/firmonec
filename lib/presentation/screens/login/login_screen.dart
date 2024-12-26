

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/views/views.dart';

class LoginScreen extends ConsumerStatefulWidget {

  const LoginScreen({super.key});


  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();

}

class LoginScreenState extends ConsumerState<LoginScreen>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginView(),
    );
  }
}

