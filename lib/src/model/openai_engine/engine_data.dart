class EngineData {
  final String id;
  final String object;
  final String owner;
  final bool ready;

  EngineData(this.id, this.object, this.owner, this.ready);
  factory EngineData.fromJson(Map<String,dynamic> json) => EngineData(
    json['id'] as String,
    json['object'] as String,
    json['owner'] as String,
    json['ready'] as bool,
  );
  Map<String,dynamic> toJson() => _EngineDataToJson(this);

  Map<String, dynamic> _EngineDataToJson(EngineData instance) =>
      <String, dynamic>{
        'id': instance.id,
        'object': instance.object,
        'owner': instance.owner,
        'ready': instance.ready,
      };
}