/*

Provider notifier

Created by Ali Osman ŞAHİN on 09/09/2025

*/

import 'package:flutter/material.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/utils/tasksegments.dart';

class GlobalNotifier extends ChangeNotifier {
  //Tasks
  Map<DateTime, List<Task>> _taskData = {};

  Map<DateTime, List<Task>> get taskData => _taskData;

  void updateTaskData(Map<DateTime, List<Task>> newTaskData) {
    _taskData = newTaskData;
    notifyListeners();
  }

  //Main page

  // --- Selected Segment
  TaskSegments _selectedSegment = TaskSegments.all;
  TaskSegments get selectedSegment => _selectedSegment;

  void setSelectedSegment(TaskSegments newSegment) {
    _selectedSegment = newSegment;
    notifyListeners();
  }

  // --- Filter Opened
  bool _filterOpened = false;
  bool get filterOpened => _filterOpened;

  void setFilterOpened(bool newFilterOpened) {
    _filterOpened = newFilterOpened;
    notifyListeners();
  }

  //Segment all

  // --- Search Value
  String _searchValue = "";
  String get searchValue => _searchValue;

  void setSearchValue(String newSearchValue) {
    _searchValue = newSearchValue;
    notifyListeners();
  }

  // --- Search Opened
  bool _searchOpened = false;
  bool get searchOpened => _searchOpened;

  void setSearchOpened(bool newSearchOpened) {
    _searchOpened = newSearchOpened;
    notifyListeners();
  }

  // --- Important
  bool _important = false;
  bool get important => _important;

  void setImportant(bool newImportant) {
    _important = newImportant;
    notifyListeners();
  }

  // --- Status
  String _done = "alldone";
  String get done => _done;

  void setDone(String newDone) {
    _done = newDone;
    notifyListeners();
  }

  // --- Date
  String _date = "alldate";
  String get date => _date;

  void setDate(String newDate) {
    _date = newDate;
    notifyListeners();
  }

  // --- Type
  String _type = "All";
  String get type => _type;

  void setType(String newType) {
    _type = newType;
    notifyListeners();
  }

  // +++ Filters
  void resetFilters() {
    _important = false;
    _done = "alldone";
    _date = "alldate";
    _type = "All";
    notifyListeners();
  }
}
