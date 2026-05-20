import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:chat_gpt_sdk/src/model/cancel/cancel_data.dart';
import 'package:chat_gpt_sdk/src/model/project_org/project_response.dart';
import 'package:chat_gpt_sdk/src/model/project_org/user_response.dart';
import 'package:chat_gpt_sdk/src/utils/constants.dart';

class ProjectAndOrg {
  final OpenAIClient _client;

  ProjectAndOrg(this._client);

  /// List projects in the organization.
  /// [limit] A limit on the number of objects to be returned.
  /// [after] A cursor for use in pagination.
  Future<ListProjectsResponse> listProjects({
    int? limit,
    String? after,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    String url = _client.apiUrl + kOrganizationProjects;
    final List<String> query = [];
    if (limit != null) query.add('limit=$limit');
    if (after != null) query.add('after=$after');
    if (query.isNotEmpty) {
      url += "?${query.join('&')}";
    }

    return _client.get<ListProjectsResponse>(
      url,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ListProjectsResponse.fromJson(it),
    );
  }

  /// Create a new project in the organization.
  /// [name] The name of the project.
  Future<ProjectResponse> createProject({
    required String name,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.post<ProjectResponse>(
      _client.apiUrl + kOrganizationProjects,
      {'name': name},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ProjectResponse.fromJson(it),
    );
  }

  /// Retrieve a specific project in the organization.
  /// [projectId] The ID of the project.
  Future<ProjectResponse> retrieveProject({
    required String projectId,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.get<ProjectResponse>(
      "${_client.apiUrl}$kOrganizationProjects/$projectId",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ProjectResponse.fromJson(it),
    );
  }

  /// Modify a project's name.
  /// [projectId] The ID of the project.
  /// [name] The new name of the project.
  Future<ProjectResponse> modifyProject({
    required String projectId,
    required String name,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.post<ProjectResponse>(
      "${_client.apiUrl}$kOrganizationProjects/$projectId",
      {'name': name},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ProjectResponse.fromJson(it),
    );
  }

  /// Archive a project.
  /// [projectId] The ID of the project.
  Future<ProjectResponse> archiveProject({
    required String projectId,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.post<ProjectResponse>(
      "${_client.apiUrl}$kOrganizationProjects/$projectId/archive",
      {},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ProjectResponse.fromJson(it),
    );
  }

  /// List users in the organization.
  /// [limit] A limit on the number of objects to be returned.
  /// [after] A cursor for use in pagination.
  Future<ListUsersResponse> listUsers({
    int? limit,
    String? after,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    String url = _client.apiUrl + kOrganizationUsers;
    final List<String> query = [];
    if (limit != null) query.add('limit=$limit');
    if (after != null) query.add('after=$after');
    if (query.isNotEmpty) {
      url += "?${query.join('&')}";
    }

    return _client.get<ListUsersResponse>(
      url,
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => ListUsersResponse.fromJson(it),
    );
  }

  /// Retrieve a specific user in the organization.
  /// [userId] The ID of the user.
  Future<UserResponse> retrieveUser({
    required String userId,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.get<UserResponse>(
      "${_client.apiUrl}$kOrganizationUsers/$userId",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => UserResponse.fromJson(it),
    );
  }

  /// Modify a user's role.
  /// [userId] The ID of the user.
  /// [role] The new role of the user ("owner" or "reader").
  Future<UserResponse> modifyUserRole({
    required String userId,
    required String role,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.post<UserResponse>(
      "${_client.apiUrl}$kOrganizationUsers/$userId",
      {'role': role},
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => UserResponse.fromJson(it),
    );
  }

  /// Delete a user from the organization.
  /// [userId] The ID of the user.
  Future<DeleteUserResponse> deleteUser({
    required String userId,
    void Function(CancelData cancelData)? onCancel,
  }) async {
    return _client.delete<DeleteUserResponse>(
      "${_client.apiUrl}$kOrganizationUsers/$userId",
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      onSuccess: (it) => DeleteUserResponse.fromJson(it),
    );
  }
}
