import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/service_card.dart';

void main() {
  testWidgets('ServiceCard widget should display service details and handle request action', (WidgetTester tester) async {
    // Variável para rastrear se a ação de solicitação foi executada
    bool requestCalled = false;

    // Constrói o widget com uma função para atualizar o estado de requestCalled
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body:  ServiceCard(
            serviceName: 'Serviço de Limpeza',
            price: 150.0,
            onRequest: () {
              requestCalled = true;
              ScaffoldMessenger.of(tester.element(find.byType(ServiceCard)))
                  .showSnackBar(SnackBar(content: Text('Solicitação enviada!')));
            },
          ),
        ),
      ),
    );

    // Verifica se o nome e o preço do serviço são exibidos corretamente
    expect(find.byKey(Key('serviceName')), findsOneWidget);
    expect(find.text('Serviço de Limpeza'), findsOneWidget);
    expect(find.byKey(Key('servicePrice')), findsOneWidget);
    expect(find.text('R\$150.00'), findsOneWidget);

    // Simula o toque no botão "Solicitar Serviço"
    await tester.tap(find.byKey(Key('requestServiceButton')));
    await tester.pump(); // Atualiza a UI para exibir o SnackBar

    // Verifica se a ação de solicitação foi chamada e o SnackBar foi exibido
    expect(requestCalled, isTrue);
    expect(find.text('Solicitação enviada!'), findsOneWidget);
  });
}
