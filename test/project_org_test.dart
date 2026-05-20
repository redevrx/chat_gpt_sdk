import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/client/client.dart';
import 'package:test/test.dart';

// A simple mock for testing the request serialization and response parsing.
class MockClient implements OpenAIClient {
  String? lastUrl;
  String? lastMethod;
  Map<String, dynamic>? lastBody;
  dynamic mockResponse;

  @override
  String get apiUrl => "https://api.openai.com/v1/";

  @override
  Future<T> get<T>(
    String url, {
    required T Function(Map<String, dynamic> p1) onSuccess,
    required void Function(CancelData p1) onCancel,
    bool returnRawData = false,
    Map<String, String>? headers,
  }) async {
    lastUrl = url;
    lastMethod = "GET";
    return onSuccess(mockResponse as Map<String, dynamic>);
  }

  @override
  Future<T> post<T>(
    String url,
    Map<String, dynamic> request, {
    required T Function(Map<String, dynamic> p1) onSuccess,
    required void Function(CancelData p1) onCancel,
    Map<String, String>? headers,
  }) async {
    lastUrl = url;
    lastMethod = "POST";
    lastBody = request;
    return onSuccess(mockResponse as Map<String, dynamic>);
  }

  @override
  Future<T> delete<T>(
    String url, {
    required T Function(Map<String, dynamic> p1) onSuccess,
    required void Function(CancelData p1) onCancel,
    Map<String, String>? headers,
  }) async {
    lastUrl = url;
    lastMethod = "DELETE";
    return onSuccess(mockResponse as Map<String, dynamic>);
  }

  // Stubs to satisfy the abstract class
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('ProjectResponse & ListProjectsResponse Models', () {
    test('fromJson and toJson projects mapping works correctly', () {
      final projectJson = {
        "object": "organization.project",
        "id": "proj_123",
        "name": "My test project",
        "created_at": 1715000000,
        "archived_at": null,
        "status": "active",
      };

      final project = ProjectResponse.fromJson(projectJson);
      expect(project.id, "proj_123");
      expect(project.name, "My test project");
      expect(project.status, "active");

      final serialized = project.toJson();
      expect(serialized['id'], "proj_123");
      expect(serialized['name'], "My test project");
    });

    test('ListProjectsResponse mapping', () {
      final listJson = {
        "object": "list",
        "data": [
          {
            "object": "organization.project",
            "id": "proj_123",
            "name": "Project A",
            "created_at": 1715000000,
            "archived_at": null,
            "status": "active",
          },
        ],
        "first_id": "proj_123",
        "last_id": "proj_123",
        "has_more": false,
      };

      final response = ListProjectsResponse.fromJson(listJson);
      expect(response.object, "list");
      expect(response.data?.length, 1);
      expect(response.data?.first.name, "Project A");
      expect(response.hasMore, false);

      final serialized = response.toJson();
      expect(serialized['first_id'], "proj_123");
      expect(serialized['data'][0]['name'], "Project A");
    });
  });

  group('UserResponse & ListUsersResponse Models', () {
    test('UserResponse mapping works correctly', () {
      final userJson = {
        "object": "organization.user",
        "id": "user_123",
        "name": "John Doe",
        "email": "john@example.com",
        "role": "owner",
        "added_at": 1715000000,
      };

      final user = UserResponse.fromJson(userJson);
      expect(user.id, "user_123");
      expect(user.email, "john@example.com");
      expect(user.role, "owner");

      final serialized = user.toJson();
      expect(serialized['id'], "user_123");
      expect(serialized['role'], "owner");
    });

    test('DeleteUserResponse mapping', () {
      final deleteJson = {
        "object": "organization.user.deleted",
        "id": "user_123",
        "deleted": true,
      };

      final response = DeleteUserResponse.fromJson(deleteJson);
      expect(response.id, "user_123");
      expect(response.deleted, true);

      final serialized = response.toJson();
      expect(serialized['deleted'], true);
    });
  });

  group('ProjectAndOrg Client API Requests', () {
    late MockClient client;
    late ProjectAndOrg api;

    setUp(() {
      client = MockClient();
      api = ProjectAndOrg(client);
    });

    test(
      'listProjects calls GET organization/projects with query strings',
      () async {
        client.mockResponse = {
          "object": "list",
          "data": [],
          "first_id": null,
          "last_id": null,
          "has_more": false,
        };

        final result = await api.listProjects(limit: 5, after: 'proj_abc');

        expect(
          client.lastUrl,
          "https://api.openai.com/v1/organization/projects?limit=5&after=proj_abc",
        );
        expect(client.lastMethod, "GET");
        expect(result.object, "list");
      },
    );

    test('createProject calls POST organization/projects', () async {
      client.mockResponse = {
        "object": "organization.project",
        "id": "proj_123",
        "name": "Brand New Project",
        "created_at": 1715000000,
        "status": "active",
      };

      final result = await api.createProject(name: "Brand New Project");

      expect(client.lastUrl, "https://api.openai.com/v1/organization/projects");
      expect(client.lastMethod, "POST");
      expect(client.lastBody, {'name': "Brand New Project"});
      expect(result.name, "Brand New Project");
    });

    test('retrieveProject calls GET organization/projects/{id}', () async {
      client.mockResponse = {
        "object": "organization.project",
        "id": "proj_123",
        "name": "My Project",
      };

      final result = await api.retrieveProject(projectId: "proj_123");

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/projects/proj_123",
      );
      expect(client.lastMethod, "GET");
      expect(result.id, "proj_123");
    });

    test('modifyProject calls POST organization/projects/{id}', () async {
      client.mockResponse = {
        "object": "organization.project",
        "id": "proj_123",
        "name": "Updated Name",
      };

      final result = await api.modifyProject(
        projectId: "proj_123",
        name: "Updated Name",
      );

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/projects/proj_123",
      );
      expect(client.lastMethod, "POST");
      expect(client.lastBody, {'name': "Updated Name"});
      expect(result.name, "Updated Name");
    });

    test(
      'archiveProject calls POST organization/projects/{id}/archive',
      () async {
        client.mockResponse = {
          "object": "organization.project",
          "id": "proj_123",
          "status": "archived",
        };

        final result = await api.archiveProject(projectId: "proj_123");

        expect(
          client.lastUrl,
          "https://api.openai.com/v1/organization/projects/proj_123/archive",
        );
        expect(client.lastMethod, "POST");
        expect(result.status, "archived");
      },
    );

    test('listUsers calls GET organization/users with query strings', () async {
      client.mockResponse = {
        "object": "list",
        "data": [],
        "first_id": null,
        "last_id": null,
        "has_more": false,
      };

      final result = await api.listUsers(limit: 10, after: 'user_abc');

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/users?limit=10&after=user_abc",
      );
      expect(client.lastMethod, "GET");
      expect(result.object, "list");
    });

    test('retrieveUser calls GET organization/users/{id}', () async {
      client.mockResponse = {
        "object": "organization.user",
        "id": "user_123",
        "email": "test@test.com",
      };

      final result = await api.retrieveUser(userId: "user_123");

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/users/user_123",
      );
      expect(client.lastMethod, "GET");
      expect(result.id, "user_123");
    });

    test('modifyUserRole calls POST organization/users/{id}', () async {
      client.mockResponse = {
        "object": "organization.user",
        "id": "user_123",
        "role": "reader",
      };

      final result = await api.modifyUserRole(
        userId: "user_123",
        role: "reader",
      );

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/users/user_123",
      );
      expect(client.lastMethod, "POST");
      expect(client.lastBody, {'role': "reader"});
      expect(result.role, "reader");
    });

    test('deleteUser calls DELETE organization/users/{id}', () async {
      client.mockResponse = {
        "object": "organization.user.deleted",
        "id": "user_123",
        "deleted": true,
      };

      final result = await api.deleteUser(userId: "user_123");

      expect(
        client.lastUrl,
        "https://api.openai.com/v1/organization/users/user_123",
      );
      expect(client.lastMethod, "DELETE");
      expect(result.deleted, true);
    });
  });
}
