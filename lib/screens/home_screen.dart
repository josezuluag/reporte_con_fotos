import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/report_service.dart';
import 'create_report_screen.dart';
import 'group_reports_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos de Reportes'),
      ),
      body: Consumer<ReportService>(
        builder: (context, reportService, child) {
          if (reportService.groups.isEmpty) {
            return Center(child: Text('No hay grupos de reportes'));
          }
          return ListView.builder(
            itemCount: reportService.groups.length,
            itemBuilder: (context, index) {
              final String group = reportService.groups[index];
              return ListTile(
                title: Text(group),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupReportsScreen(group: group),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateReportScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
