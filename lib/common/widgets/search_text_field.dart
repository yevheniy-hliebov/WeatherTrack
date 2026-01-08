import 'package:flutter/material.dart';
import 'package:weathertrack/common/widgets/glass_container.dart';
import 'package:weathertrack/common/widgets/loader.dart';
import 'package:weathertrack/common/widgets/search_suggestions.dart';
import 'package:weathertrack/core/constants/corners.dart';
import 'package:weathertrack/core/theme/theme.dart';

class SearchTextField<T> extends StatefulWidget {
  final String hintText;
  final bool isLoading;
  final List<T> suggestions;
  final String Function(T item) displaySuggestionText;
  final String Function(T item) displaySelectionText;
  final void Function(String query)? onChanged;
  final void Function(T item)? onSelect;

  const SearchTextField({
    super.key,
    this.hintText = 'Enter text...',
    this.isLoading = false,
    this.suggestions = const [],
    required this.displaySuggestionText,
    required this.displaySelectionText,
    this.onChanged,
    this.onSelect,
  });

  @override
  State<SearchTextField<T>> createState() => _SearchTextFieldState<T>();
}

class _SearchTextFieldState<T> extends State<SearchTextField<T>> {
  late MenuController menuController;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    menuController = MenuController();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MenuTheme(
          data: AppSearchTheme.menu,
          child: MenuAnchor(
            controller: menuController,
            builder: (context, controller, child) {
              return GlassContainer(
                bordered: controller.isOpen,
                radius: AppCorners.xl,
                child: SearchBar(
                  controller: searchController,
                  hintText: widget.hintText,
                  trailing: [_buildIconOrLoader()],
                  onTap: () => controller.open(),
                  onChanged: widget.onChanged,
                ),
              );
            },
            menuChildren: [
              SearchSuggestions<T>(
                displayItemText: widget.displaySuggestionText,
                suggestions: widget.suggestions,
                onTap: (item) {
                  widget.onSelect?.call(item);
                  searchController.text = widget.displaySelectionText(item);
                  menuController.close();
                },
                maxWidth: constraints.maxWidth,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconOrLoader() {
    return widget.isLoading ? const Loader(size: 18) : const Icon(Icons.search);
  }
}
