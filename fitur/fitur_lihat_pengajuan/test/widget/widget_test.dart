import 'package:common/constant/test_tags/test_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget preparePengajuFilter(){
    return const SizedBox();
  }

  testWidgets('Diberikan filter pengaju yang terbuka, '
      'ketika suatu checkbox di suatu item di click, '
      'maka status check akan berubah dari item tersebut', (tester) async {
    await tester.pumpWidget(preparePengajuFilter());

    final checkboxes = find.byType(Checkbox).at(1);
    final checkboxWidgets = [
      for (int i = 0 ; i < 5 ; i++)
        tester.widget<Checkbox>(checkboxes.at(i))
    ];
    
    await tester.tap(checkboxes.at(1));
    await tester.tap(checkboxes.at(3));
    await tester.pump();

    expect(checkboxWidgets[0].value, isFalse);
    expect(checkboxWidgets[1].value, isTrue);
    expect(checkboxWidgets[2].value, isFalse);
    expect(checkboxWidgets[3].value, isTrue);
    expect(checkboxWidgets[4].value, isFalse);

    await tester.tap(checkboxes.at(1));
    await tester.tap(checkboxes.at(4));
    await tester.pump();

    expect(checkboxWidgets[0].value, isFalse);
    expect(checkboxWidgets[1].value, isFalse);
    expect(checkboxWidgets[2].value, isFalse);
    expect(checkboxWidgets[3].value, isTrue);
    expect(checkboxWidgets[4].value, isTrue);
  } , tags: [TestTags.fastTest]);
}