import 'package:flutter/material.dart';
import 'package:weathertrack/common/widgets/glass_container.dart';
import 'package:weathertrack/common/widgets/loader.dart';
import 'package:weathertrack/common/widgets/search_suggestions.dart';
import 'package:weathertrack/core/constants/colors.dart';
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
  final String errorMessage;

  const SearchTextField({
    super.key,
    this.hintText = 'Enter text...',
    this.isLoading = false,
    this.suggestions = const [],
    required this.displaySuggestionText,
    required this.displaySelectionText,
    this.onChanged,
    this.onSelect,
    this.errorMessage = '',
  });

  @override
  State<SearchTextField<T>> createState() => _SearchTextFieldState<T>();
}

class _SearchTextFieldState<T> extends State<SearchTextField<T>> {
  late MenuController _menuController;
  late TextEditingController _searchController;
  late FocusNode _searchNode;

  @override
  void initState() {
    super.initState();
    _menuController = MenuController();
    _searchController = TextEditingController();
    _searchNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        TapRegion(
          onTapOutside: (_) => _searchNode.unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return MenuTheme(
                data: AppSearchTheme.menu,
                child: MenuAnchor(
                  controller: _menuController,
                  builder: (context, controller, child) {
                    return GlassContainer(
                      bordered: controller.isOpen,
                      radius: AppCorners.xl,
                      child: SearchBar(
                        focusNode: _searchNode,
                        controller: _searchController,
                        hintText: widget.hintText,
                        trailing: [_buildIconOrLoader()],
                        onTap: () => controller.open(),
                        onChanged: (value) {
                          controller.open();
                          widget.onChanged?.call(value);
                        },
                      ),
                    );
                  },
                  menuChildren: [
                    SearchSuggestions<T>(
                      displayItemText: widget.displaySuggestionText,
                      suggestions: widget.suggestions,
                      onTap: (item) {
                        widget.onSelect?.call(item);
                        _searchController.text = widget.displaySelectionText(
                          item,
                        );
                        _searchNode.unfocus();
                        _menuController.close();
                      },
                      maxWidth: constraints.maxWidth,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (widget.errorMessage.isNotEmpty)
          Text(
            widget.errorMessage,
            style: TextTheme.of(
              context,
            ).bodyMedium?.copyWith(color: AppColors.error),
          ),
      ],
    );
  }

  Widget _buildIconOrLoader() {
    return widget.isLoading ? const Loader(size: 18) : const Icon(Icons.search);
  }
}
