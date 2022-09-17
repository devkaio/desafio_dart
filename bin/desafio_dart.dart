import 'dart:io';

import 'package:desafio_dart/console.dart';

void main() {
  print("\x1B[2J\x1B[0;0H");

  final Console console = Console();

  while (true) {
    stdout.write('''
Escolha uma opção:
1) Cadastrar uma empresa
2) Pesquisar Empresa por CNPJ
3) Pesquisar Empresa por CPF/CNPJ do Sócio
4) Listar Empresas
5) Excluir Empresa
0) Encerrar programa
''');

    final opcao = stdin.readLineSync()!;
    String input = "";

    print("\x1B[2J\x1B[0;0H");

    if (opcao == "0") break;

    switch (opcao) {
      case "1":
        console.cadastrarEmpresa();
        break;
      case "2":
        console.pesquisarEmpresaPorCNPJ();
        break;
      case "3":
        console.pesquisarEmpresaPorSocio();
        break;
      case "4":
        console.listarEmpresas();
        break;
      case "5":
        print("Digite o ID da empresa que deseja excluir");
        input = stdin.readLineSync()!;
        console.excluirEmpresa(input);
        break;
      default:
        print("Opção Inválida. Tente novamente");
    }
  }
}
