import 'package:flutter/material.dart';

/// Чистый UI компонент для ввода описания транзакции.
/// Не содержит бизнес-логики и state management.
class TransactionDescriptionField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final int maxLines;

  const TransactionDescriptionField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText ?? 'Описание',
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

