import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reporte_con_fotos/models/report.dart';
import 'screens/home_screen.dart';
import 'screens/create_report_screen.dart';
import 'screens/report_detail_screen.dart';
import 'services/report_service.dart';
import 'services/database_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(
          create: (context) => DatabaseService(),
        ),
        ChangeNotifierProxyProvider<DatabaseService, ReportService>(
          create: (context) => ReportService(
            Provider.of<DatabaseService>(context, listen: false),
          ),
          update: (context, databaseService, previous) =>
              ReportService(databaseService),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Reportes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/create_report': (context) => CreateReportScreen(),
        '/report_detail': (context) => ReportDetailScreen(
              report: ModalRoute.of(context)!.settings.arguments as Report,
            ),
      },
    );
  }
}
