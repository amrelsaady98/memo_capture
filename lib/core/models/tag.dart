import 'package:floor/floor.dart';

@Entity(primaryKeys: ['id'], tableName: 'tag')
class TagItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;
  bool isSelected;

  TagItem({
    this.id,
    required this.name,
    this.isSelected = false,
  });

  @override
  String toString() {
    return 'TagItem{id: $id, name: $name, isSelected: $isSelected}';
  }
}
