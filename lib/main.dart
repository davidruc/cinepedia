//! Para velocidad de la aplicación es recomendable importar paquetes en orden: 1ro paquetes de material o propios de flutter, luego paquetes de flutter y por último nuestras dependencias. 
import 'package:flutter/material.dart';

import 'package:cinepedia/config/router/app_router.dart';
import 'package:cinepedia/config/theme/app_theme.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme()
    );
  }
}