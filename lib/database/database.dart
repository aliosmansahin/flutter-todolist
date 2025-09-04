import 'package:drift/drift.dart';

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get dateAndTime => dateTime()();
  TextColumn get type => text()();
  BoolColumn get shouldNotify => boolean().withDefault(const Constant(false))();
  BoolColumn get notificationSent =>
      boolean().withDefault(const Constant(false))();
}

abstract class TasksView extends View {
  Tasks get tasks;

  @override
  Query as() => select([tasks.title]).from(tasks);
}

@DriftDatabase(tables: [Tasks], views: [TasksView])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from == 2) {
        await migrator.addColumn(tasks, tasks.shouldNotify);
        await migrator.addColumn(tasks, tasks.notificationSent);
      }
    },
  );
}
