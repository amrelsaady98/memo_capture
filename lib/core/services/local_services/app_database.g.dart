// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

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

  MeduimDao? _meduimDaoInstance;

  TagDao? _tagDoaInstance;

  MemoryDao? _memoryDaoInstance;

  MemoryTagDao? _memoryTagDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `medium` (`id` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tag` (`id` INTEGER, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `memory` (`id` INTEGER, `title` TEXT NOT NULL, `imagePath` TEXT NOT NULL, `dateTime` INTEGER NOT NULL, `isFavourite` INTEGER NOT NULL, `medium` TEXT, `description` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `memory_tags` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `memoryId` INTEGER NOT NULL, `tagId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MeduimDao get meduimDao {
    return _meduimDaoInstance ??= _$MeduimDao(database, changeListener);
  }

  @override
  TagDao get tagDoa {
    return _tagDoaInstance ??= _$TagDao(database, changeListener);
  }

  @override
  MemoryDao get memoryDao {
    return _memoryDaoInstance ??= _$MemoryDao(database, changeListener);
  }

  @override
  MemoryTagDao get memoryTagDao {
    return _memoryTagDaoInstance ??= _$MemoryTagDao(database, changeListener);
  }
}

class _$MeduimDao extends MeduimDao {
  _$MeduimDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mediumItemInsertionAdapter = InsertionAdapter(
            database,
            'medium',
            (MediumItem item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MediumItem> _mediumItemInsertionAdapter;

  @override
  Future<List<MediumItem>> getAllMediumItems() async {
    return _queryAdapter.queryList('SELECT * FROM medium',
        mapper: (Map<String, Object?> row) =>
            MediumItem(id: row['id'] as int?, name: row['name'] as String));
  }

  @override
  Future<void> insertMediumItem(MediumItem mediumItem) async {
    await _mediumItemInsertionAdapter.insert(
        mediumItem, OnConflictStrategy.abort);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tagItemInsertionAdapter = InsertionAdapter(
            database,
            'tag',
            (TagItem item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TagItem> _tagItemInsertionAdapter;

  @override
  Future<List<TagItem>> getAllTagItems() async {
    return _queryAdapter.queryList('SELECT * FROM tag',
        mapper: (Map<String, Object?> row) => TagItem(
            id: row['id'] as int?,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0));
  }

  @override
  Future<List<TagItem>> getMemoryTags(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tag JOIN memory_tags ON tag.id = memory_tags.tagId WHERE memory_tags.memoryId = ?1',
        mapper: (Map<String, Object?> row) => TagItem(id: row['id'] as int?, name: row['name'] as String, isSelected: (row['isSelected'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> insertTagItem(TagItem tagItem) async {
    await _tagItemInsertionAdapter.insert(tagItem, OnConflictStrategy.abort);
  }
}

class _$MemoryDao extends MemoryDao {
  _$MemoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _memoryInsertionAdapter = InsertionAdapter(
            database,
            'memory',
            (Memory item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'imagePath': item.imagePath,
                  'dateTime': item.dateTime,
                  'isFavourite': item.isFavourite ? 1 : 0,
                  'medium': item.medium,
                  'description': item.description
                }),
        _memoryUpdateAdapter = UpdateAdapter(
            database,
            'memory',
            ['id'],
            (Memory item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'imagePath': item.imagePath,
                  'dateTime': item.dateTime,
                  'isFavourite': item.isFavourite ? 1 : 0,
                  'medium': item.medium,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Memory> _memoryInsertionAdapter;

  final UpdateAdapter<Memory> _memoryUpdateAdapter;

  @override
  Future<Memory?> getMemoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM memory WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Memory(
            id: row['id'] as int?,
            title: row['title'] as String,
            imagePath: row['imagePath'] as String,
            dateTime: row['dateTime'] as int,
            isFavourite: (row['isFavourite'] as int) != 0,
            medium: row['medium'] as String?,
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<int?> getLastId() async {
    return _queryAdapter.query('SELECT last_insert_rowid()',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<Memory>> getAllMemoryItems() async {
    return _queryAdapter.queryList('SELECT * FROM memory',
        mapper: (Map<String, Object?> row) => Memory(
            id: row['id'] as int?,
            title: row['title'] as String,
            imagePath: row['imagePath'] as String,
            dateTime: row['dateTime'] as int,
            isFavourite: (row['isFavourite'] as int) != 0,
            medium: row['medium'] as String?,
            description: row['description'] as String?));
  }

  @override
  Future<List<Memory>> getMemoryByTag(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM memory JOIN memory_tags ON memory.id = memory_tags.memoryId WHERE memory_tags.tagId = ?1',
        mapper: (Map<String, Object?> row) => Memory(id: row['id'] as int?, title: row['title'] as String, imagePath: row['imagePath'] as String, dateTime: row['dateTime'] as int, isFavourite: (row['isFavourite'] as int) != 0, medium: row['medium'] as String?, description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertMemory(Memory memory) async {
    await _memoryInsertionAdapter.insert(memory, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMemory(Memory memory) async {
    await _memoryUpdateAdapter.update(memory, OnConflictStrategy.abort);
  }
}

class _$MemoryTagDao extends MemoryTagDao {
  _$MemoryTagDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _memoryTagInsertionAdapter = InsertionAdapter(
            database,
            'memory_tags',
            (MemoryTag item) => <String, Object?>{
                  'id': item.id,
                  'memoryId': item.memoryId,
                  'tagId': item.tagId
                }),
        _memoryTagDeletionAdapter = DeletionAdapter(
            database,
            'memory_tags',
            ['id'],
            (MemoryTag item) => <String, Object?>{
                  'id': item.id,
                  'memoryId': item.memoryId,
                  'tagId': item.tagId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MemoryTag> _memoryTagInsertionAdapter;

  final DeletionAdapter<MemoryTag> _memoryTagDeletionAdapter;

  @override
  Future<List<MemoryTag>> findTagsForMemory(int memoryId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM memory_tags WHERE memoryId = ?1',
        mapper: (Map<String, Object?> row) => MemoryTag(
            id: row['id'] as int?,
            memoryId: row['memoryId'] as int,
            tagId: row['tagId'] as int),
        arguments: [memoryId]);
  }

  @override
  Future<void> insertMemoryTag(MemoryTag memoryTag) async {
    await _memoryTagInsertionAdapter.insert(
        memoryTag, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMemoryTags(List<MemoryTag> memoryTags) async {
    await _memoryTagInsertionAdapter.insertList(
        memoryTags, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMemoryTag(MemoryTag memoryTag) async {
    await _memoryTagDeletionAdapter.delete(memoryTag);
  }
}
