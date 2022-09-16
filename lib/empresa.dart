import 'package:uuid/uuid.dart';

import 'endereco.dart';
import 'socio.dart';

class Empresa {
  final _id = Uuid().v1();
  final DateTime _dataCriacao = DateTime.now();

  String? razaoSocial = "";

  String? nomeFantasia = "";

  String cnpj;

  Endereco? endereco;

  String? telefone = "";

  Socio? socio;

  Empresa(
    this.cnpj, {
    this.razaoSocial,
    this.nomeFantasia,
    this.endereco,
    this.telefone,
    this.socio,
  });

  String get cnpjFormatado {
    if (cnpj.length == 14) {
      final formated =
          "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12)}";
      return formated;
    }
    return cnpj;
  }

  String get telefoneFormatado {
    return "(${telefone!.substring(0, 2)})${telefone!.substring(2, 7)}-${telefone!.substring(7)}";
  }

  String get id => _id;

  DateTime get dataCriacao => _dataCriacao;
}
