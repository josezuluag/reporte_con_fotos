import 'package:flutter/material.dart';
import 'dart:io';
import '../models/report.dart';
import 'edit_report_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditReportScreen(report: report),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Grupo: ${report.group}'),
            SizedBox(height: 8),
            Text('Fecha: ${report.date}'),
            SizedBox(height: 16),
            Text('Descripción: ${report.description}'),
            SizedBox(height: 16),
            Text('Imágenes:'),
            SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: report.imagePaths.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(report.imagePaths[index]),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
