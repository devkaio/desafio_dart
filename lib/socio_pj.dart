import 'package:desafio_dart/socio.dart';

class SocioPJ extends Socio {
  String razaoSocial;
  String nomeFantasia;
  String cnpj;

  SocioPJ({
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.cnpj,
    required super.endereco,
  }) : super(cnpj, nome: razaoSocial);
}
