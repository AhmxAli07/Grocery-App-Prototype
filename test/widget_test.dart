import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prototype/utils/shopping_actions.dart';
import 'package:prototype/widgets/startup_failure.dart';
import 'package:prototype/widgets/button.dart';
import 'package:prototype/payment/pay.dart';

void main() {
  test('Product parsing tolerates missing and malformed fields', () async {
    final db = FakeFirebaseFirestore();
    final ref = db.collection('products').doc('a');
    await ref.set({
      'price': 5.5,
      'image': 123,
      'name': {'bad': true},
    });
    final product = await ref.get();
    expect(productField(product, 'name'), 'Unnamed item');
    expect(productField(product, 'price'), '5.5');
    expect(productField(product, 'unit'), '');
  });

  test(
    'Repeated saves are idempotent and isolated to the signed-in user path',
    () async {
      final db = FakeFirebaseFirestore();
      final ref = db.collection('design').doc('apple');
      await ref.set({'name': 'Apple', 'price': 5.5, 'image': '', 'unit': 'kg'});
      final product = await ref.get();
      await saveProduct(db, 'alice', 'cart', product);
      await saveProduct(db, 'alice', 'cart', product);
      expect((await db.collection('user/alice/cart').get()).docs.length, 1);
      expect((await db.collection('user/bob/cart').get()).docs, isEmpty);
    },
  );

  test(
    'Products with matching IDs in different collections stay distinct',
    () async {
      final db = FakeFirebaseFirestore();
      final a = db.doc('design/a');
      final b = db.doc('Apple/a');
      await a.set({'name': 'First'});
      await b.set({'name': 'Second'});
      await saveProduct(db, 'alice', 'cart', await a.get());
      await saveProduct(db, 'alice', 'cart', await b.get());
      expect((await db.collection('user/alice/cart').get()).docs.length, 2);
    },
  );

  test('Moving a favorite retains its data and removes the source', () async {
    final db = FakeFirebaseFirestore();
    final source = db.doc('user/alice/fav/apple');
    await source.set({
      'name': 'Apple',
      'price': 5.5,
      'unit': 'kg',
      'image': '',
    });
    await moveFavorite(db, 'alice', await source.get());
    expect((await source.get()).exists, false);
    expect(
      (await db.doc('user/alice/cart/apple').get()).data()?['name'],
      'Apple',
    );
  });

  testWidgets('Startup failure offers retry at narrow phone width', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var retried = false;
    await tester.pumpWidget(
      MaterialApp(home: StartupFailure(onRetry: () => retried = true)),
    );
    await tester.tap(find.text('Retry'));
    expect(retried, true);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Loading button cannot submit a duplicate request', (
    tester,
  ) async {
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Roundbutton(
            title: 'Sign up',
            onpressed: () => calls++,
            loading: true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(InkWell));
    expect(calls, 0);
  });

  testWidgets('Payment screen truthfully states its incomplete status', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PaymentScreen()));
    expect(
      find.text('Payments and checkout are not implemented.'),
      findsOneWidget,
    );
  });
}
