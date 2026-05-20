class ProjectResponse {
  final String? object;
  final String? id;
  final String? name;
  final int? createdAt;
  final int? archivedAt;
  final String? status;

  ProjectResponse({
    this.object,
    this.id,
    this.name,
    this.createdAt,
    this.archivedAt,
    this.status,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProjectResponse();
    return ProjectResponse(
      object: json['object'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as int?,
      archivedAt: json['archived_at'] as int?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'object': object,
    'id': id,
    'name': name,
    'created_at': createdAt,
    'archived_at': archivedAt,
    'status': status,
  };
}

class ListProjectsResponse {
  final String? object;
  final List<ProjectResponse>? data;
  final String? firstId;
  final String? lastId;
  final bool? hasMore;

  ListProjectsResponse({
    this.object,
    this.data,
    this.firstId,
    this.lastId,
    this.hasMore,
  });

  factory ListProjectsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ListProjectsResponse();
    return ListProjectsResponse(
      object: json['object'] as String?,
      data: json['data'] == null
          ? null
          : (json['data'] as List)
                .map((x) => ProjectResponse.fromJson(x as Map<String, dynamic>))
                .toList(),
      firstId: json['first_id'] as String?,
      lastId: json['last_id'] as String?,
      hasMore: json['has_more'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'object': object,
    'data': data?.map((x) => x.toJson()).toList(),
    'first_id': firstId,
    'last_id': lastId,
    'has_more': hasMore,
  };
}
