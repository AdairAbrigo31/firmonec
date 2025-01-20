
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';

class RolesDocumentsQuipuxScreen extends StatelessWidget {

  const RolesDocumentsQuipuxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: const RolesDocumentsQuipuxView(),
      backgroundColor: Colors.white,
    );
  }


}