import 'package:flutter_test/flutter_test.dart';

class CalcularValorTotalTest {
  double calcularValorTotal(double valorServico, double taxaServico) {
    return valorServico + (valorServico * taxaServico);
  }
  
  void main() {
    group('Calcular Valor Total', () {
      test('deve retornar o valor total com taxa de serviço incluída', () {
        final valorServico = 100.0;
        final taxaServico = 0.1;

        final valorTotal = calcularValorTotal(valorServico, taxaServico);

        expect(valorTotal, equals(110.0));
      });

      test('deve retornar o valor original se a taxa de serviço for zero', () {
        final valorServico = 200.0;
        final taxaServico = 0.0;

        final valorTotal = calcularValorTotal(valorServico, taxaServico);

        expect(valorTotal, equals(200.0));
      });
    });
  }
}
