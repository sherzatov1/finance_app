import 'package:flutter/material.dart';

class CardFinance extends StatelessWidget {
  final Widget child;

  const CardFinance({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF706BFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: child,
      //ЭТО ФОН В ГЛАВНОМ ЭКРАНЕ ДЛЯ ФИНАНСОВОЙ КАРТЫ
    );
  }
}
