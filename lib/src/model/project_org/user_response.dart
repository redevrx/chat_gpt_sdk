class UserResponse {
  final String? object;
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final int? addedAt;

  UserResponse({
    this.object,
    this.id,
    this.name,
    this.email,
    this.role,
    this.addedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserResponse();
    return UserResponse(
      object: json['object'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      addedAt: json['added_at'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'object': object,
    'id': id,
    'name': name,
    'email': email,
    'role': role,
    'added_at': addedAt,
  };
}

class ListUsersResponse {
  final String? object;
  final List<UserResponse>? data;
  final String? firstId;
  final String? lastId;
  final bool? hasMore;

  ListUsersResponse({
    this.object,
    this.data,
    this.firstId,
    this.lastId,
    this.hasMore,
  });

  factory ListUsersResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ListUsersResponse();
    return ListUsersResponse(
      object: json['object'] as String?,
      data: json['data'] == null
          ? null
          : (json['data'] as List)
                .map((x) => UserResponse.fromJson(x as Map<String, dynamic>))
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

class DeleteUserResponse {
  final String? object;
  final String? id;
  final bool? deleted;

  DeleteUserResponse({this.object, this.id, this.deleted});

  factory DeleteUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DeleteUserResponse();
    return DeleteUserResponse(
      object: json['object'] as String?,
      id: json['id'] as String?,
      deleted: json['deleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'object': object,
    'id': id,
    'deleted': deleted,
  };
}
