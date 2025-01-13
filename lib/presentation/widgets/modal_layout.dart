import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';


class ModalLayouts {

  final BuildContext _context;

  ModalLayouts( this._context );


  Widget showSimpleModal({

    Widget? child,

    String? title,

    Color? colorTitle,

    double? quitSpace,

    bool? quitx

  }) {

      return Center(

        child: SingleChildScrollView(

          child: Dialog(

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(8)

            ),

            

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                //icono de X cerrar

                Container(

                  width: double.infinity,

                  alignment: Alignment.centerRight,

                  padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 8 ),

                  child: (quitx == null)

                  ? InkWell(

                    splashColor: Colors.transparent, // Desactivar el color del efecto de onda

                    highlightColor: Colors.transparent, // Desactivar el color de resaltado

                    child: const Icon(Icons.close, color: Colors.amber),

                    onTap: () => _context.pop(),

                  ) : null

                ),

          

                Container(

                  padding: const EdgeInsets.all(10),

                  child: Column(

                    mainAxisSize: MainAxisSize.min,

                    children: [



                      if(title != null)

                      Text(

                        title,

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 18,

                          fontWeight: FontWeight.w600,

                          color: colorTitle

                        ),

                      ),

                      

                      Expanded(

                        flex: 0,

                        child: child!

                      ),

                    ],

                  )

                ),

              ],

            ),

          ),

        ),

      );
  }
}