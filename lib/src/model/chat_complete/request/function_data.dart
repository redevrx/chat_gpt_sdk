@Deprecated('')
class FunctionData {
  ///The name of the function to be called.
  /// Must be a-z, A-Z, 0-9, or contain underscores
  /// and dashes, with a maximum length of 64.
  /// [name]
  final String name;

  ///The description of what the function does.
  ///[description]
  final String? description;

  ///parameters object Optional
  /// The parameters the functions accepts,
  /// described as a JSON Schema object.
  /// See the
  /// <a href="https://platform.openai.com/docs/guides/gpt/function-calling">guide</a> for examples,
  /// and the <a href="https://json-schema.org/understanding-json-schema/">JSON Schema reference</a>
  /// for documentation about the format.
  /// [parameters]
  final Map<String, dynamic>? parameters;

  FunctionData({required this.name, this.description, this.parameters});

  Map<String, dynamic> toJson() => Map.of(
        {
          "name": name,
          "description": description,
          "parameters": parameters,
        },
      );
}
