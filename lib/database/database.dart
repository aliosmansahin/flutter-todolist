import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get dateAndTime => dateTime()();
  TextColumn get type => text()();
  BoolColumn get shouldNotify => boolean().withDefault(const Constant(true))();
  BoolColumn get notificationSent =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  BoolColumn get important => boolean()();
}

abstract class TasksView extends View {
  Tasks get tasks;

  @override
  Query as() => select([tasks.title]).from(tasks);
}

// The function that creates database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'my_db.sqlite');
    return SqfliteQueryExecutor(path: path, logStatements: true);
  });
}

@DriftDatabase(tables: [Tasks], views: [TasksView])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from == 2) {
        await migrator.addColumn(tasks, tasks.shouldNotify);
        await migrator.addColumn(tasks, tasks.notificationSent);
      } else if (from == 3) {
        await migrator.addColumn(tasks, tasks.completed);
        await migrator.addColumn(tasks, tasks.important);
      }
    },
  );
}
