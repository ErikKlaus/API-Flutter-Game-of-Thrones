import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_14_flutter/main.dart';

void main() {
  testWidgets('Splash menampilkan logo', (WidgetTester tester) async {
    await tester.pumpWidget(const SevenKingdomsApp());

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/Logo_Game_of_Thrones.png',
      ),
      findsOneWidget,
    );
  });
}
