import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:epic_hire/shared/utils/string.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class OpenToScreen extends ConsumerStatefulWidget {
  final int userId;
  const OpenToScreen({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenToScreenState();
}

class _OpenToScreenState extends ConsumerState<OpenToScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(epicUserProvider(widget.userId)).valueOrNull;
    if (user == null) return const Center(child: CircularProgressIndicator());

    if (user.openTo.isEmpty) {
      return Center(
        child: Text(
          'No open opportunities',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: EpicHireTheme.of(context).dirtyWhite,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: user.openTo.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => OpenToCard(user.openTo[index]),
    );
  }
}

class OpenToCard extends ConsumerWidget {
  final OpenTo openTo;
  const OpenToCard(this.openTo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = EpicHireTheme.of(context);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      color: theme.foreground,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  openTo.type.toCapitalized,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.dirtyWhite,
                  ),
                ),
                if (openTo.startDate != null)
                  Text(
                    'Starts ${_formatDate(openTo.startDate!)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: theme.dirtyWhite),
                  ),
                if (openTo.internshipTimeFrame.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      openTo.internshipTimeFrame,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.dirtyWhite,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            if (openTo.jobCategories.isNotEmpty)
              _buildSection(
                context,
                title: 'Categories',
                items: openTo.jobCategories.map((c) => c.name).toList(),
              ),

            if (openTo.locations.isNotEmpty)
              _buildSection(
                context,
                title: 'Locations',
                items: openTo.locations
                    .map((l) => l.locality.toString())
                    .toList(),
              ),

            if (openTo.jobTypes.isNotEmpty)
              _buildSection(
                context,
                title: 'Job Types',
                items: openTo.jobTypes,
              ),

            if (openTo.jobEnvironments.isNotEmpty)
              _buildSection(
                context,
                title: 'Environments',
                items: openTo.jobEnvironments,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: EpicHireTheme.of(context).dirtyWhite,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: items
                .map(
                  (item) => Chip(
                    label: Text(item),
                    visualDensity: VisualDensity.compact,
                    color: WidgetStateProperty<Color>.fromMap({
                      WidgetState.any: EpicHireTheme.of(context).foreground,
                    }),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
