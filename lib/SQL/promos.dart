class Promos{
  final String imagen;
  Promos(
  {
    required this.imagen,
  });
  //dynamic map
  Map<String, dynamic> toMap() {
    return {
      'imagen':imagen
    };
  }
}