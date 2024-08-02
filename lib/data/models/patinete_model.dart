class PatineteModel {
  final int? id;
  final String marca;
  final String modelo;
  final String tipo;
  final String color;

  PatineteModel({
    this.id,
    required this.marca,
    required this.modelo,
    required this.tipo,
    required this.color,
  });

  // Método para convertir el objeto json a un PatineteModel
  factory PatineteModel.fromJson(Map<String, dynamic> json) {
    return PatineteModel(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      tipo: json['tipo'],
      color: json['color'],
    );
  }

  // Métdo para convertir el objeto a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'tipo': tipo,
      'color': color
    };
  }
}
