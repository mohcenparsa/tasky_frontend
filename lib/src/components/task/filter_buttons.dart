import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onSelectFilter;

  const FilterButtons({
    Key? key,
    required this.filters,
    required this.selectedFilter,
    required this.onSelectFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: selectedFilter == filter,
              onSelected: (_) => onSelectFilter(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}
