import 'package:desafio_dart/socio.dart';

class SocioPF extends Socio {
  String cpf;

  SocioPF({
    required super.nome,
    required this.cpf,
    required super.endereco,
  }) : super(cpf);
}
