import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';


class ModalLayouts {

  final BuildContext _context;

  ModalLayouts( this._context );


  Widget showSimpleModal({

    Widget? child,

    String? title,

    String? textButton = 'Button',

    void Function()? onPressed,

    bool hideButton = false,

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

                      

                      if( child != null ) ...[

                        if (quitSpace == null ) SizedBox( height: quitSpace ?? 10 ),

            

                        Expanded(

                          flex: 0,

                          child: child

                        ),

                      ],

                      

                      if( !hideButton ) ...[

                        SizedBox( height: quitSpace ?? 10 ),

          

                        PrimaryButton(

                          text: textButton!,

                          onPressed: onPressed!,

                        ),

                      ]

          

                    ],

                  )

                ),

              ],

            ),

          ),

        ),

      );
  }





  Widget showTwoDecisionModal({

    Widget? child,

    required String title,

    String? textOneButton = 'One Button',

    String? textTwoButton = 'Two Button',

    void Function()? onPressedOne,

    void Function()? onPressedTwo,

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

                  

                  Container(

                    width: double.infinity,

                    alignment: Alignment.centerRight,

                    padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 8 ),

                    child: InkWell(

                      splashColor: Colors.transparent, // Desactivar el color del efecto de onda

                      highlightColor: Colors.transparent, // Desactivar el color de resaltado

                      child: const Icon(Icons.close, color: Colors.amber),

                      onTap: () => _context.pop(),

                    )

                  ),
            

                  Container(

                    padding: EdgeInsets.all(10),
          

                    child: Column(

                      mainAxisSize: MainAxisSize.min,

                      children: [



                        Text(

                          title,

                          textAlign: TextAlign.center,

                          style: const TextStyle(

                            fontSize: 18,

                            fontWeight: FontWeight.w600

                          ),

                        ),



                        if( child != null ) ...[



                          SizedBox( height: 10),

              

                          Expanded(

                            flex: 0,

                            child: child

                          ),

                          

                        ],



                        

                        SizedBox( height: 10 ),

          

                        PrimaryButton(

                          text: textOneButton!,

                          onPressed: onPressedOne!,

                        ),



                        SizedBox( height: 5 ),

          

                        PrimaryButton(

                          text: textTwoButton!,

                          onPressed: onPressedTwo!,

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