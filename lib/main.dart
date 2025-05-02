import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/theme/app_theme.dart';
import 'configuration/configuration.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Para los iconos de navegación (parte inferior)
    systemNavigationBarColor: Colors.white, // Color de fondo de la barra de navegación
    systemNavigationBarIconBrightness: Brightness.dark, // Esto hará que los iconos sean oscuros (negro)
    
    // También puedes configurar la barra de estado (parte superior)
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // Íconos oscuros en la barra de estado
  ));
  await dotenv.load();
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp.router(
      
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: !isDarkMode ? ThemeMode.light : ThemeMode.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
