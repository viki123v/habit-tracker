import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/home/day_widgets.dart';
import 'package:habit_tracker/src/ui/screens/report/report_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final TextEditingController _reflectionController = TextEditingController();
  String? _loadedReflection;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReportViewModel>();
    _syncReflection(viewModel.reflectionNote);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          tooltip: 'Back',
        ),
        title: const Text('Progress report'),
      ),
      body: SafeArea(
        child: switch (viewModel.status) {
          ReportLoadStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          ReportLoadStatus.error => _ReportError(
            message: viewModel.errorMessage ?? 'Could not load report',
            onRetry: viewModel.loadReport,
          ),
          ReportLoadStatus.ready => _ReportContent(
            viewModel: viewModel,
            reflectionController: _reflectionController,
          ),
        },
      ),
    );
  }

  void _syncReflection(String note) {
    if (_loadedReflection == note) return;
    _loadedReflection = note;
    _reflectionController.text = note;
  }
}

class _ReportContent extends StatelessWidget {
  const _ReportContent({
    required this.viewModel,
    required this.reflectionController,
  });

  final ReportViewModel viewModel;
  final TextEditingController reflectionController;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d');
    final range =
        '${dateFormat.format(viewModel.startDate)} - ${dateFormat.format(viewModel.today)}';

    return RefreshIndicator(
      onRefresh: viewModel.loadReport,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          Spacings.spacious,
          Spacings.loose,
          Spacings.spacious,
          Spacings.section,
        ),
        children: [
          Text(range, style: TextStyle(color: ColorPalette.neutral)),
          SizedBox(height: Spacings.tight),
          Text('Last 14 days').title(),
          SizedBox(height: Spacings.relaxed),
          _HistoryCard(days: viewModel.days),
          SizedBox(height: Spacings.relaxed),
          _SummaryGrid(viewModel: viewModel),
          SizedBox(height: Spacings.relaxed),
          _ReflectionCard(
            controller: reflectionController,
            isSaving: viewModel.isSavingReflection,
            onSave: () => viewModel.saveReflection(reflectionController.text),
          ),
          SizedBox(height: Spacings.relaxed),
          _InsightsCard(insights: viewModel.insights),
        ],
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.viewModel});

  final ReportViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final successPercent = (viewModel.successRate * 100).round();

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.55,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: Spacings.tight,
      mainAxisSpacing: Spacings.tight,
      children: [
        _MetricCard(
          label: 'Success rate',
          value: '$successPercent%',
          icon: Icons.insights_outlined,
          color: ColorPalette.primary,
        ),
        _MetricCard(
          label: 'Done',
          value: '${viewModel.completedHabits}',
          icon: Icons.check_circle_outline,
          color: ColorPalette.success,
        ),
        _MetricCard(
          label: 'Missed',
          value: '${viewModel.failedHabits}',
          icon: Icons.restart_alt,
          color: ColorPalette.warning,
        ),
        _MetricCard(
          label: 'Full days',
          value: '${viewModel.successfulDays}/${viewModel.trackedDays}',
          icon: Icons.calendar_today_outlined,
          color: ColorPalette.info,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacings.cozy),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(value).heading(), Text(label).caption()],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.days});

  final List<DailyReport> days;

  @override
  Widget build(BuildContext context) {
    final trackedDays = days.where((day) => day.hasHabits).length;
    final successfulDays = days.where((day) => day.isSuccessful).length;
    final successRate = trackedDays == 0
        ? 0
        : ((successfulDays / trackedDays) * 100).round();

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: ColorPalette.primary.withAlpha((255 * 0.1).round()),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Spacings.cozy,
          Spacings.cozy,
          Spacings.cozy,
          Spacings.tight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('14-Day Consistency').heading(),
                    Text('$successRate% fully completed days'),
                  ],
                ),
                Icon(
                  Icons.emoji_events_outlined,
                  color: ColorPalette.supportColor3,
                  size: 38,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Spacings.tight,
                bottom: Spacings.tight,
              ),
              child: GridView.count(
                crossAxisCount: 7,
                childAspectRatio: 0.62,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: Spacings.tight,
                crossAxisSpacing: Spacings.extraTight,
                children: days.map((day) => _DayStatus(day: day)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayStatus extends StatelessWidget {
  const _DayStatus({required this.day});

  final DailyReport day;

  @override
  Widget build(BuildContext context) {
    final label = DateFormat('E').format(day.date).substring(0, 1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: Spacings.extraTight),
        if (!day.hasHabits)
          const UpcomingDayWidget(size: 34)
        else if (day.isSuccessful)
          const CompletedDayWidget(size: 34)
        else
          const MissedDayWidget(size: 34),
      ],
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  const _ReflectionCard({
    required this.controller,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController controller;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacings.cozy),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily reflection').heading(),
            SizedBox(height: Spacings.tight),
            TextField(
              controller: controller,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'Write a note about today...',
              ),
            ),
            SizedBox(height: Spacings.cozy),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: isSaving ? null : onSave,
                icon: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(isSaving ? 'Saving' : 'Save note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsCard extends StatelessWidget {
  const _InsightsCard({required this.insights});

  final ReportInsights insights;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacings.cozy),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Insights').heading(),
            SizedBox(height: Spacings.tight),
            _InsightRow(
              icon: Icons.star_border,
              label: 'Best day',
              value: insights.bestDayLabel,
              color: ColorPalette.primary,
            ),
            _InsightRow(
              icon: Icons.flag_outlined,
              label: 'Needs care',
              value: insights.toughestDayLabel,
              color: ColorPalette.warning,
            ),
            _InsightRow(
              icon: Icons.favorite_border,
              label: 'Recovery',
              value: insights.recoveryLabel,
              color: ColorPalette.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacings.tight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(width: Spacings.cozy),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(label).caption(), Text(value)],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportError extends StatelessWidget {
  const _ReportError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Spacings.spacious),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center).caption(),
            SizedBox(height: Spacings.cozy),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
