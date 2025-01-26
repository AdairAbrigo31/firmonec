
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/views.dart';

class DocumentsSignedScreen extends StatelessWidget {

  const DocumentsSignedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.amber,

        title: const Align( 
          
          alignment: Alignment.center, 
          
          child: Text("Documentos firmados", style: TextStyle(fontSize: 18),),
          
        ),
        
      ),
      
      body: const DocumentsSignedView(),
    );
  }


}