class GenerateImage {
  /// prompt string Required A text description of the desired image(s). The maximum length is 1000 characters.
  final String prompt;

  ///The number of images to generate. Must be between 1 and 10.
  final int n;

  ///The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
  final String size;

  ///The format in which the generated images are returned. Must be one of url or b64_json.
  final String response_format;

  ///A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  final String user;

  GenerateImage(this.prompt, this.n,
      {this.size = "1024x1024", this.response_format = "url", this.user = ""});

  Map<String, dynamic> toJson() => Map.of({
        "prompt": this.prompt,
        "n": this.n,
        "size": this.size,
        "response_format": this.response_format,
        "user": this.user
      });
}
