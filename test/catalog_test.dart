import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prototype/Fruits/tab1.dart';
import 'package:prototype/Screens/Bar/search.dart';
import 'package:prototype/Screens/Bar/home.dart';

void main() {
  testWidgets(
    'Home keeps category navigation when catalog is empty on a narrow phone',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 568));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(home: GroceryHome(database: FakeFirebaseFirestore())),
      );
      await tester.pumpAndSettle();
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('No products available.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Empty product collection renders an empty state', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: TAB1(database: FakeFirebaseFirestore())),
    );
    await tester.pumpAndSettle();
    expect(find.text('No items available.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final width in [320.0, 390.0]) {
    testWidgets(
      'One malformed product does not index past the collection at $width pixels',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 568));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final database = FakeFirebaseFirestore();
        await database.doc('fruits/apple').set({'name': 'Apple', 'price': 5.5});
        await tester.pumpWidget(MaterialApp(home: TAB1(database: database)));
        await tester.pumpAndSettle();
        expect(find.text('Apple'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('Explore scrolls to meat on a short phone', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MaterialApp(home: ExploreScreen()));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Pumpkin'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Pumpkin'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
