import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weathertrack/common/widgets/loader.dart';
import 'package:weathertrack/common/widgets/search_suggestions.dart';
import 'package:weathertrack/common/widgets/search_text_field.dart';
import 'package:weathertrack/core/constants/colors.dart';

void main() {
  group('SearchTextField (widget tests)', () {
    testWidgets('should show search icon by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTextField<String>(
              isLoading: false,
              displaySuggestionText: (item) => item,
              displaySelectionText: (item) => item,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(Loader), findsNothing);
    });

    testWidgets('should show loader when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTextField<String>(
              isLoading: true,
              displaySuggestionText: (item) => item,
              displaySelectionText: (item) => item,
            ),
          ),
        ),
      );

      expect(find.byType(Loader), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);
      final Loader loaderWidget = tester.widget(find.byType(Loader));
      expect(loaderWidget.size, 18);
    });

    testWidgets('should show error message when errorMessage is provided', (
      WidgetTester tester,
    ) async {
      const errorMessage = 'City not found';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTextField<String>(
              errorMessage: errorMessage,
              displaySuggestionText: (item) => item,
              displaySelectionText: (item) => item,
            ),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text(errorMessage));
      expect(textWidget.style?.color, AppColors.error);
    });

    testWidgets('should call onChanged when text is entered', (
      WidgetTester tester,
    ) async {
      String? capturedQuery;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTextField<String>(
              onChanged: (query) => capturedQuery = query,
              displaySuggestionText: (item) => item,
              displaySelectionText: (item) => item,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(SearchBar), 'London');

      expect(capturedQuery, 'London');
    });

    testWidgets('should open MenuAnchor when tapped or text changed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTextField<String>(
              suggestions: const ['London', 'Paris'],
              displaySuggestionText: (item) => item,
              displaySelectionText: (item) => item,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SearchBar));
      await tester.pumpAndSettle();

      expect(find.byType(SearchSuggestions<String>), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(find.byType(SearchSuggestions<String>), findsNothing);

      await tester.enterText(find.byType(SearchBar), 'Lon');
      await tester.pumpAndSettle();

      expect(find.byType(SearchSuggestions<String>), findsOneWidget);
      expect(find.text('London'), findsOneWidget);
    });

    testWidgets(
      'should call onSelect and close menu when a suggestion is tapped',
      (WidgetTester tester) async {
        String? selectedCity;
        final suggestions = ['London', 'Paris', 'Berlin'];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SearchTextField<String>(
                suggestions: suggestions,
                displaySuggestionText: (item) => item,
                displaySelectionText: (item) => 'Selected: $item',
                onSelect: (city) => selectedCity = city,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(SearchBar), 'Lon');
        await tester.pumpAndSettle();

        final suggestionItem = find.text('London');
        expect(suggestionItem, findsOneWidget);

        await tester.tap(suggestionItem);
        await tester.pumpAndSettle();

        expect(selectedCity, 'London');

        expect(find.text('Selected: London'), findsOneWidget);

        expect(find.byType(SearchSuggestions<String>), findsNothing);

        final FocusNode focusNode = tester
            .widget<SearchBar>(find.byType(SearchBar))
            .focusNode!;
        expect(focusNode.hasFocus, isFalse);
      },
    );

    testWidgets('should unfocus and close menu when tapping outside', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SearchTextField<String>(
                  suggestions: const ['London'],
                  displaySuggestionText: (item) => item,
                  displaySelectionText: (item) => item,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SearchBar));
      await tester.pumpAndSettle();

      final FocusNode focusNode = tester
          .widget<SearchBar>(find.byType(SearchBar))
          .focusNode!;
      expect(
        focusNode.hasFocus,
        isTrue,
        reason: 'Field should be focused after tap',
      );
      expect(
        find.byType(SearchSuggestions<String>),
        findsOneWidget,
        reason: 'Menu should be open',
      );

      await tester.tapAt(const Offset(1, 1));
      await tester.pumpAndSettle();

      expect(
        focusNode.hasFocus,
        isFalse,
        reason: 'Field should lose focus after tapping outside',
      );
      expect(
        find.byType(SearchSuggestions<String>),
        findsNothing,
        reason: 'Menu should close after tapping outside',
      );
    });
  });
}
