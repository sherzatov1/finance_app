import 'package:finance_app/features/application/add_transaction_provider.dart';
import 'package:finance_app/features/application/transaction_date_provider.dart';
import 'package:finance_app/features/design_scroll_fin/transaction_description_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarOpisanie extends ConsumerWidget {
  const CalendarOpisanie({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateText = ref.watch(formattedTransactionDateProvider);
    final timeText = ref.watch(formattedTransactionTimeProvider);
    final selectedDateTime = ref.watch(transactionDateTimeProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(text: 'ДЕТАЛИ'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DateTimeActionCard(
                  icon: Icons.calendar_today,
                  text: dateText,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      final newDateTime = DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                        selectedDateTime.hour,
                        selectedDateTime.minute,
                      );
                      ref.read(transactionDateTimeProvider.notifier).state =
                          newDateTime;
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DateTimeActionCard(
                  icon: Icons.access_time,
                  text: timeText,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    );

                    if (picked != null) {
                      final newDateTime = DateTime(
                        selectedDateTime.year,
                        selectedDateTime.month,
                        selectedDateTime.day,
                        picked.hour,
                        picked.minute,
                      );
                      ref.read(transactionDateTimeProvider.notifier).state =
                          newDateTime;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const DescriptionField(),
        ],
      ),
    );
  }
}

class DateTimeActionCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DateTimeActionCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionField extends ConsumerStatefulWidget {
  const DescriptionField({super.key});

  @override
  ConsumerState<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends ConsumerState<DescriptionField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(transactionDescriptionProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDescriptionChanged(String value) {
    ref.read(transactionDescriptionProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(
      transactionDescriptionProvider,
      (previous, next) {
        if (_controller.text != next) {
          _controller.text = next;
        }
      },
    );

    return TransactionDescriptionField(
      controller: _controller,
      onChanged: _onDescriptionChanged,
      hintText: 'Описание',
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }
}

