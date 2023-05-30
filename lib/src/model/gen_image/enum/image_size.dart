///The size of the generated images.
enum ImageSize {
  size1024("1024x1024"),
  size512("512x512"),
  size256("256x256");

  const ImageSize(this.size);
  final String size;
}
