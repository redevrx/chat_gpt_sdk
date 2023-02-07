class Permission {
  final String id;
  final String object;
  final int created;
  final bool allowCreate_engine;
  final bool allowSampling;
  final bool allowLogprobs;
  final bool allowSearchIndices;
  final bool allowView;
  final bool allowFineTuning;
  final String organization;
  final dynamic group;
  final bool? isBlocking;

  Permission(this.id, this.object, this.created, this.allowCreate_engine, this.allowSampling, this.allowLogprobs,
      this.allowSearchIndices, this.allowView, this.allowFineTuning, this.organization, this.group, this.isBlocking);

  factory Permission.fromJson(Map<String,dynamic> json) =>  Permission(
    json['id'] as String,
    json['object'] as String,
    json['created'] as int,
    json['allow_create_engine'] as bool,
    json['allow_sampling'] as bool,
    json['allow_logprobs'] as bool,
    json['allow_search_indices'] as bool,
    json['allow_view'] as bool,
    json['allow_fine_tuning'] as bool,
    json['organization'] as String,
    json['group'],
    json['is_blocking'] as bool?,
  );

  Map<String,dynamic> toJson() =>  <String, dynamic>{
    'id': id,
    'object': object,
    'created': created,
    'allow_create_engine': allowCreate_engine,
    'allow_sampling': allowSampling,
    'allow_logprobs': allowLogprobs,
    'allow_search_indices': allowSearchIndices,
    'allow_view': allowView,
    'allow_fine_tuning': allowFineTuning,
    'organization': organization,
    'group': group,
    'is_blocking': isBlocking,
  };

}