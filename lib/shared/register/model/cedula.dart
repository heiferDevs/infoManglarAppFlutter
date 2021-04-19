class Cedula {
  String cedula;
  String nombre;
  String estadoCivil;
  String nacionalidad;
  String calleDomicilio;
  String domicilio;
  String genero;

  String error;

  Cedula({
    this.cedula,
    this.error,
    this.nombre,
    this.estadoCivil,
    this.nacionalidad,
    this.calleDomicilio,
    this.genero,
    this.domicilio,
  });

  // FROM API
  factory Cedula.fromJson(Map<String, dynamic> json) {
    return Cedula(
      cedula: json['Cedula'],
      nombre: json['Nombre'],
      genero: json['genero'],
      domicilio: json['domicilio'],
      estadoCivil: json['estadoCivil'],
      nacionalidad: json['nacionalidad'],
      calleDomicilio: json['calleDomicilio'],
      error: json['Error'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() => {
        'cedula': cedula,
        'error': error,
        'nombre': nombre,
        'estadoCivil': estadoCivil,
        'nacionalidad': nacionalidad,
        'calleDomicilio': calleDomicilio,
        'genero': genero,
        'domicilio': domicilio,
      };
}
