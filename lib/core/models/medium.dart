import 'package:floor/floor.dart';

@Entity(tableName: 'medium', primaryKeys: ['id'])
class MediumItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  @ignore
  bool isSelected;

  MediumItem({
    this.id,
    required this.name,
    this.isSelected = false,
  });
}
