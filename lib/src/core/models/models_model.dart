class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json['id'] as String,
        root: json['root'] as String,
        created: json['created'] as int,
      );
}
