import 'dart:io';

import 'empresa.dart';
import 'endereco.dart';
import 'socio.dart';
import 'socio_pf.dart';
import 'socio_pj.dart';

class Console {
  final List<Empresa> _listaEmpresas = [];

  void cadastrarEmpresa() {
    print("\x1B[2J\x1B[0;0H");

    final String razaoSocial = _inputEmpresa("a", "Razao Social");
    final String nomeFantasia = _inputEmpresa("o", "Nome Fantasia");
    String cnpj = _inputEmpresa("o", "CNPJ");

    while (_validaCNPJ(cnpj)) {
      print(
          "CNPJ inválido. O CNPJ deve ser composto por 14 numeros inteiros, sem pontos nem traços.");
      cnpj = _inputEmpresa("o", "CNPJ");
    }

    String telefone = _inputEmpresa("o", "Telefone");
    while (telefone.length != 11) {
      print(
          "Telefone inválido. O telefone deve ser composto por 11 numeros inteiros (DDD+9+numero), sem pontos nem traços.");
      telefone = _inputEmpresa("o", "Telefone");
    }

    final endereco = _cadastraEndereco(Empresa);

    Socio socio;

    print("O Sócio é (1) Pessoa Física ou (2) Pessoa Jurídica?");

    String input = stdin.readLineSync()!;

    while (input.isNotEmpty) {
      if (input == "1") {
        socio = _cadastrarSocio(SocioPF);
        _listaEmpresas.add(
          Empresa(
            cnpj,
            razaoSocial: razaoSocial,
            nomeFantasia: nomeFantasia,
            endereco: endereco,
            telefone: telefone,
            socio: socio,
          ),
        );
        break;
      } else if (input == "2") {
        socio = _cadastrarSocio(SocioPJ);
        _listaEmpresas.add(
          Empresa(
            cnpj,
            razaoSocial: razaoSocial,
            nomeFantasia: nomeFantasia,
            endereco: endereco,
            telefone: telefone,
            socio: socio,
          ),
        );
        break;
      } else {
        print(
            "Opção inválida. Digite 1 para cadastrar Sócio Pessoa Física ou 2 para Sócio Pessoa Jurídica.");
        input = stdin.readLineSync()!;
      }
    }
  }

  void pesquisarEmpresaPorCNPJ() {
    print("\x1B[2J\x1B[0;0H");

    if (_listaEmpresas.isEmpty) {
      print(
          "\nNão há empresas cadastradas no momento. Faça um cadastro antes de prosseguir.\n");
      return;
    }

    print("Digite o CNPJ da empresa que deseja pesquisar");
    final input = stdin.readLineSync()!;

    for (var element in _listaEmpresas) {
      if (element.cnpj == input) {
        mostrarDadosEmpresa(element);
      } else {
        print(
            "\nNão foi possível encontrar a empresa informada. Tente novamente.\n");
      }
    }
  }

  void pesquisarEmpresaPorSocio() {
    print("\x1B[2J\x1B[0;0H");

    if (_listaEmpresas.isEmpty) {
      print(
          "\nNão há empresas cadastradas no momento. Faça um cadastro antes de prosseguir.\n");
      return;
    }

    print("Digite o CPF ou CNPJ do sócio da empresa que deseja pesquisar");
    final input = stdin.readLineSync()!;
    if (input.length == 11) {
      for (var element in _listaEmpresas) {
        if (element.socio!.documento == input) {
          mostrarDadosEmpresa(element);
        }
      }
    } else if (input.length == 14) {
      for (var element in _listaEmpresas) {
        if (element.socio!.documento == input) {
          mostrarDadosEmpresa(element);
        }
      }
    } else {
      print(
          "Não foi possível encontrar o sócio com esses dados. Tente novamente.");
    }
  }

  void mostrarDadosEmpresa(Empresa empresa) {
    print("\x1B[2J\x1B[0;0H");

    stdout.writeln('''
ID: ${empresa.id}
CNPJ: ${empresa.cnpjFormatado} Data Cadastro: ${empresa.dataCriacao}
Razão Social: ${empresa.razaoSocial}
Nome Fantasia: ${empresa.nomeFantasia}
Telefone: ${empresa.telefoneFormatado}
Endereço: ${empresa.endereco?.logradouro}, ${empresa.endereco?.numero}, ${empresa.endereco?.bairro}, ${empresa.endereco?.cidade}/${empresa.endereco?.estado}, ${empresa.endereco?.cepFormatado}
Sócio:
CPF: ${empresa.socio?.documentoFormatado}
Nome Completo: ${empresa.socio?.nome}
Endereço: ${empresa.socio?.endereco.logradouro}, ${empresa.socio?.endereco.numero}, ${empresa.socio?.endereco.bairro}, ${empresa.socio?.endereco.cidade}/${empresa.socio?.endereco.estado}, ${empresa.socio?.endereco.cepFormatado}
''');
  }

  void listarEmpresas() {
    print("\x1B[2J\x1B[0;0H");

    //utilização do método forEach para iteração de elemento de uma lista
    // _listaEmpresas.forEach((element) {
    //   print(element.razaoSocial);
    // });

    _listaEmpresas.sort((a, b) => a.razaoSocial!.compareTo(b.razaoSocial!));

    print("Lista de Empresas Cadastradas:");
    //utilização do for para iteração de elementos de uma lista
    for (var element in _listaEmpresas) {
      print('''
ID: ${element.id}
CNPJ: ${element.cnpjFormatado} Data Cadastro: ${element.dataCriacao}
Razão Social: ${element.razaoSocial}
''');
    }
  }

  void excluirEmpresa(String empresaID) {
    //TODO: resolver o problema de exluir item da lista
    print("\x1B[2J\x1B[0;0H");

    if (_listaEmpresas.isEmpty) {
      print(
          "\nNão há empresas cadastradas no momento. Faça um cadastro antes de prosseguir.\n");
      return;
    }

    for (var element in _listaEmpresas) {
      if (element.id == empresaID) {
        print("Deseja realmente excluir a empresa ${element.razaoSocial}? S/N");
        final input = stdin.readLineSync()!;
        if (input == "s" || input == "S") {
          _listaEmpresas.removeWhere((element) {
            return element.id == empresaID;
          });

          print("Empresa excluída com sucesso");
        }
      }
    }
  }

  //Métodos de acesso privado à classe Console. Geralmente se tratam de funções
  //para reutilização interna com objetivo de reduzir repetições de código

  //TODO: refatorar para receber string no lugar do tipo (analisar viabilidade)
  String _input(String artigo, String input, Type tipo) {
    switch (tipo) {
      case Empresa:
        print("Digite $artigo $input da Empresa");
        break;
      case SocioPF:
        print("Digite $artigo $input do Sócio Pessoa Física");
        break;
      case SocioPJ:
        print("Digite $artigo $input do Sócio Pessoa Jurídica");
        break;
      default:
        print("erro desconhecido");
    }

    return stdin.readLineSync()!;
  }

  String _inputEmpresa(String artigo, String input) {
    print("Digite $artigo $input da Empresa");
    return stdin.readLineSync()!;
  }

  Endereco _cadastraEndereco(Type tipo) {
    String logradouro;
    int? numero;
    String? complemento;
    String bairro;
    String cidade;
    String estado;

    //TODO: adicionar tratamento com base no tipo de entrada

    logradouro = _input("o", "logradouro", tipo);
    numero = int.tryParse(_input("o", "numero", tipo));
    complemento = _input("o", "complemento", tipo);
    bairro = _input("o", "bairro", tipo);
    cidade = _input("a", "cidade", tipo);
    estado = _input("as", "iniciais do Estado", tipo).toUpperCase();

    while (estado.length != 2) {
      print("Estado inválido. O Estado deve ser composto por apenas 2 letras.");
      estado = _input("as", "iniciais do Estado", tipo).toUpperCase();
    }

    String cep = _input("o", "CEP", tipo);
    while (cep.length != 8) {
      print(
          "CEP inválido. O CEP deve conter 8 números inteiros, sem traços nem pontos");
      cep = _input("o", "CEP", tipo);
    }

    return Endereco(
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
    );
  }

  Socio _cadastrarSocio(Type type) {
    String razaoSocial;
    String nomeSocio;
    String documentoSocio;
    Endereco endereco;

    if (type == SocioPF) {
      nomeSocio = _input("o", "nome", SocioPF);
      documentoSocio = _input("o", "CPF", SocioPF);
      while (_validaCPF(documentoSocio)) {
        print(
            "CPF inválido. O CPF deve conter 11 numeros inteiros, sem pontos nem traços.");
        documentoSocio = _input("o", "CPF", SocioPF);
      }
      endereco = _cadastraEndereco(SocioPF);

      return SocioPF(
        nome: nomeSocio,
        cpf: documentoSocio,
        endereco: endereco,
      );
    } else {
      razaoSocial = _input("a", "Razão Social", SocioPJ);
      nomeSocio = _input("o", "Nome Fantasia", SocioPJ);
      documentoSocio = _input("o", "CNPJ", SocioPJ);

      while (_validaCNPJ(documentoSocio)) {
        print(
            "CNPJ inválido. O CNPJ deve ser composto por 14 numeros inteiros, sem pontos nem traços.");
        documentoSocio = _input("o", "CNPJ", SocioPJ);
      }

      endereco = _cadastraEndereco(SocioPJ);

      return SocioPJ(
        razaoSocial: razaoSocial,
        nomeFantasia: nomeSocio,
        cnpj: documentoSocio,
        endereco: endereco,
      );
    }
  }

  bool _validaCNPJ(String input) {
    if (input.length != 14 ||
        input.contains("/") ||
        input.contains("-") ||
        input.contains(".")) {
      return true;
    } else {
      return false;
    }
  }

  //TODO: verificar por que não está funcionando essa validação
  bool _validaCPF(String input) {
    if (input.length != 11 || input.contains("-") || input.contains(".")) {
      return true;
    } else {
      return false;
    }
  }
}
