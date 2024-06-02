import 'package:flutter/material.dart';
import 'package:tasky/src/helpers/string_utils.dart';

class FilterButtons extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onSelectFilter;

  const FilterButtons({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onSelectFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: filters.map((filter) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(
                capitalize(
                  filter,
                ),
                style: const TextStyle(fontSize: 10)),
            selected: selectedFilter == filter,
            onSelected: (bool selected) {
              onSelectFilter(filter);
            },
          ),
        );
      }).toList(),
    );
  }
}
