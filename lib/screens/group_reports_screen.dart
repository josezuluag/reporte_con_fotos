import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/report_service.dart';
import '../models/report.dart';
import 'report_detail_screen.dart';

class GroupReportsScreen extends StatelessWidget {
  final String group;

  GroupReportsScreen({required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes de $group'),
      ),
      body: FutureBuilder<List<Report>>(
        future: Provider.of<ReportService>(context, listen: false)
            .getReportsByGroup(group),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay reportes en este grupo'));
          }

          final reports = snapshot.data!;
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final Report report = reports[index];
              return ListTile(
                title: Text(report.title),
                subtitle: Text(report.date),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportDetailScreen(report: report),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
