import 'package:floor/floor.dart';

@Entity(primaryKeys: ['id'], tableName: 'memory')
class Memory {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String title;
  String imagePath;
  int dateTime;
  bool isFavourite;
  String? medium;
  String? description;

  Memory({
    this.id,
    required this.title,
    required this.imagePath,
    required this.dateTime,
    this.isFavourite = false,
    this.medium,
    this.description,
  });

  @override
  String toString() {
    return 'Memory{id: $id, title: $title, imagePath: $imagePath, dateTime: $dateTime, isFavourite: $isFavourite, medium: $medium, description: $description}';
  }
}
