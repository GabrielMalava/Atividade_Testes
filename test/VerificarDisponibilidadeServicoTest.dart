import 'package:flutter_test/flutter_test.dart';

class VerificarDisponibilidadeServicoTest {
  final String nome;
  final List<DateTime> horariosOcupados;

  VerificarDisponibilidadeServicoTest(this.nome, this.horariosOcupados);

  bool isDisponivel(DateTime horarioDesejado) {
    for (var horario in horariosOcupados) {
      if (horario.isAtSameMomentAs(horarioDesejado)) {
        return false;
      }
    }
    return true;
  }
  
  void main() {
    group('Verificar Disponibilidade do Serviço', () {
      test('deve retornar true se o horário desejado estiver disponível', () {
        final servico = VerificarDisponibilidadeServicoTest('Limpeza', [
          DateTime(2024, 11, 10, 14, 0),
        ]);

        final horarioDesejado = DateTime(2024, 11, 10, 16, 0);

        expect(servico.isDisponivel(horarioDesejado), isTrue);
      });

      test('deve retornar false se o horário desejado estiver ocupado', () {
        final servico = VerificarDisponibilidadeServicoTest('Limpeza', [
          DateTime(2024, 11, 10, 14, 0),
        ]);

        final horarioDesejado = DateTime(2024, 11, 10, 14, 0);

        expect(servico.isDisponivel(horarioDesejado), isFalse);
      });
    });
  }
}
