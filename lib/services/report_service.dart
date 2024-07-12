import 'package:flutter/material.dart';
import 'package:reporte_con_fotos/models/report.dart';
import 'package:reporte_con_fotos/services/database_service.dart';

class ReportService extends ChangeNotifier {
  final DatabaseService _databaseService;
  List<Report> _reports = [];
  List<String> _groups = [];

  ReportService(this._databaseService) {
    loadReports();
    loadGroups();
  }

  List<Report> get reports => _reports;
  List<String> get groups => _groups;

  Future<void> loadReports() async {
    _reports = await _databaseService.getReports();
    notifyListeners();
  }

  Future<void> loadGroups() async {
    _groups = await _databaseService.getGroups();
    notifyListeners();
  }

  Future<void> addReport(Report report) async {
    final newReport = await _databaseService.insertReport(report);
    _reports.add(newReport);
    if (!_groups.contains(report.group)) {
      _groups.add(report.group);
    }
    notifyListeners();
  }

  Future<void> updateReport(Report report) async {
    await _databaseService.updateReport(report);
    int index = _reports.indexWhere((r) => r.id == report.id);
    if (index != -1) {
      _reports[index] = report;
    }
    notifyListeners();
  }

  Future<List<Report>> getReportsByGroup(String group) async {
    return await _databaseService.getReportsByGroup(group);
  }
}
