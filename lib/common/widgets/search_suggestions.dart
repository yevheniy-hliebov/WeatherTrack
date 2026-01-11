import 'package:flutter/material.dart';
import 'package:weathertrack/common/widgets/glass_container.dart';
import 'package:weathertrack/core/constants/corners.dart';

class SearchSuggestions<T> extends StatelessWidget {
  final List<T> suggestions;
  final String Function(T item) displayItemText;
  final void Function(T item)? onTap;
  final double maxWidth;

  const SearchSuggestions({
    super.key,
    this.suggestions = const [],
    required this.displayItemText,
    this.onTap,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      bordered: true,
      radius: AppCorners.xl,
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    final ScrollController scrollController = ScrollController();
    if (suggestions.length > 5) {
      return SizedBox(
        height: 280,
        child: RawScrollbar(
          controller: scrollController,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: suggestions.length,
            itemBuilder: (context, index) => _buildTile(suggestions[index]),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: .min,
      children: suggestions.map((item) => _buildTile(item)).toList(),
    );
  }

  Widget _buildTile(T item) {
    return ListTile(
      title: Text(displayItemText(item)),
      onTap: () => onTap?.call(item),
    );
  }
}
