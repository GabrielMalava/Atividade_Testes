import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mock_http_client.mocks.dart'; 




class MockClient extends Mock implements http.Client {}

// Função simulando requisição GET com filtro
Future<List<Map<String, dynamic>>> fetchServicos(http.Client client, String categoria) async {
  final response = await client.get(Uri.parse('https://api.exemplo.com/servicos'));

  if (response.statusCode == 200) {
    List servicos = jsonDecode(response.body);
    return servicos.where((servico) => servico['categoria'] == categoria).toList();
  } else {
    throw Exception('Erro ao carregar serviços');
  }
}

void main() {
  group('FetchServicosTest', () {
    test('deve retornar apenas serviços da categoria Limpeza', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://api.exemplo.com/servicos')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([
                  {'id': 1, 'nome': 'Limpeza Residencial', 'categoria': 'Limpeza'},
                  {'id': 2, 'nome': 'Limpeza Comercial', 'categoria': 'Limpeza'},
                  {'id': 3, 'nome': 'Manutenção de Jardins', 'categoria': 'Jardinagem'},
                ]),
                200,
              ));

      final servicosFiltrados = await fetchServicos(client, 'Limpeza');

      expect(servicosFiltrados.length, 2);
      expect(servicosFiltrados[0]['nome'], 'Limpeza Residencial');
      expect(servicosFiltrados[1]['nome'], 'Limpeza Comercial');
    });
  });
}
