class Endereco {
  String? logradouro = "";
  int? numero = 0;
  String? complemento = "";
  String? bairro = "";
  String? cidade = "";
  String? estado = "";
  final String? cep;

  Endereco([
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
  ]);

  String get cepFormatado {
    return "${cep!.substring(0, 2)}.${cep!.substring(2, 5)}-${cep!.substring(5)}";
  }
}
