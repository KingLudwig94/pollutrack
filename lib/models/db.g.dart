// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HeartRatesDao? _heartRatesDaoInstance;

  ExposuresDao? _exposuresDaoInstance;

  PmsDao? _pmsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HR` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Exposure` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PM25` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HeartRatesDao get heartRatesDao {
    return _heartRatesDaoInstance ??= _$HeartRatesDao(database, changeListener);
  }

  @override
  ExposuresDao get exposuresDao {
    return _exposuresDaoInstance ??= _$ExposuresDao(database, changeListener);
  }

  @override
  PmsDao get pmsDao {
    return _pmsDaoInstance ??= _$PmsDao(database, changeListener);
  }
}

class _$HeartRatesDao extends HeartRatesDao {
  _$HeartRatesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _hRInsertionAdapter = InsertionAdapter(
            database,
            'HR',
            (HR item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _hRUpdateAdapter = UpdateAdapter(
            database,
            'HR',
            ['id'],
            (HR item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _hRDeletionAdapter = DeletionAdapter(
            database,
            'HR',
            ['id'],
            (HR item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HR> _hRInsertionAdapter;

  final UpdateAdapter<HR> _hRUpdateAdapter;

  final DeletionAdapter<HR> _hRDeletionAdapter;

  @override
  Future<List<HR>> findHeartRatesbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HR WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => HR(row['id'] as int?, row['value'] as int, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<HR>> findAllHeartRates() async {
    return _queryAdapter.queryList('SELECT * FROM HR',
        mapper: (Map<String, Object?> row) => HR(
            row['id'] as int?,
            row['value'] as int,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertHeartRate(HR heartRates) async {
    await _hRInsertionAdapter.insert(heartRates, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateHeartRate(HR heartRates) async {
    await _hRUpdateAdapter.update(heartRates, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteHeartRate(HR heartRates) async {
    await _hRDeletionAdapter.delete(heartRates);
  }
}

class _$ExposuresDao extends ExposuresDao {
  _$ExposuresDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exposureInsertionAdapter = InsertionAdapter(
            database,
            'Exposure',
            (Exposure item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _exposureUpdateAdapter = UpdateAdapter(
            database,
            'Exposure',
            ['id'],
            (Exposure item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _exposureDeletionAdapter = DeletionAdapter(
            database,
            'Exposure',
            ['id'],
            (Exposure item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Exposure> _exposureInsertionAdapter;

  final UpdateAdapter<Exposure> _exposureUpdateAdapter;

  final DeletionAdapter<Exposure> _exposureDeletionAdapter;

  @override
  Future<List<Exposure>> findExposuresbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Exposure WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Exposure(row['id'] as int?, row['value'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Exposure>> findAllExposures() async {
    return _queryAdapter.queryList('SELECT * FROM Exposure',
        mapper: (Map<String, Object?> row) => Exposure(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Exposure?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Exposure(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Exposure?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Exposure(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertExposure(Exposure exposures) async {
    await _exposureInsertionAdapter.insert(exposures, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateExposure(Exposure exposures) async {
    await _exposureUpdateAdapter.update(exposures, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteExposure(Exposure exposures) async {
    await _exposureDeletionAdapter.delete(exposures);
  }
}

class _$PmsDao extends PmsDao {
  _$PmsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pM25InsertionAdapter = InsertionAdapter(
            database,
            'PM25',
            (PM25 item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _pM25UpdateAdapter = UpdateAdapter(
            database,
            'PM25',
            ['id'],
            (PM25 item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _pM25DeletionAdapter = DeletionAdapter(
            database,
            'PM25',
            ['id'],
            (PM25 item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PM25> _pM25InsertionAdapter;

  final UpdateAdapter<PM25> _pM25UpdateAdapter;

  final DeletionAdapter<PM25> _pM25DeletionAdapter;

  @override
  Future<List<PM25>> findPmsbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PM25 WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => PM25(row['id'] as int?, row['value'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<PM25>> findAllPms() async {
    return _queryAdapter.queryList('SELECT * FROM PM25',
        mapper: (Map<String, Object?> row) => PM25(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertPm(PM25 pms) async {
    await _pM25InsertionAdapter.insert(pms, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePm(PM25 pms) async {
    await _pM25UpdateAdapter.update(pms, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePm(PM25 pms) async {
    await _pM25DeletionAdapter.delete(pms);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
