import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  

  Stream<String> getLoadingMessages() {

    final messages = <String>[
    "Cargando películas",
    "Comprando palomitas de maíz",
    "Cargando populares",
    "Viendo el padrino. . .",
    "Cargando . . .",
    "Cargando . . . (x2)",
    "Cargando . . . (x3)",
    "Esto está tardando demasiado . . .",
  ];

    return Stream.periodic(const Duration(seconds: 1), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          const SizedBox(height: 40),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 40),


          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if ( !snapshot.hasData) return const Text("cargando...");

              return Text( snapshot.data! );
            },
          )
        ]
      )
    );
  }
}
