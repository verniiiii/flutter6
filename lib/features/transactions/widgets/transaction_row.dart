import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;
  final ValueChanged<Transaction> onEdit;

  const TransactionRow({
    super.key,
    required this.transaction,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  IconData _getIconForCategory(String category) {
    final icons = {
      'Зарплата': Icons.work,
      'Фриланс': Icons.computer,
      'Инвестиции': Icons.trending_up,
      'Подарок': Icons.card_giftcard,
      'Продукты': Icons.shopping_cart,
      'Транспорт': Icons.directions_car,
      'Развлечения': Icons.movie,
      'Одежда': Icons.checkroom,
      'Здоровье': Icons.local_hospital,
      'Образование': Icons.school,
      'Жилье': Icons.home,
      'Рестораны': Icons.restaurant,
    };
    return icons[category] ?? Icons.receipt;
  }

  @override
  Widget build(BuildContext context) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final iconColor = transaction.isExpense ? Colors.red : Colors.green;

    return Dismissible(
      key: Key(transaction.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(transaction.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(
            _getIconForCategory(transaction.category),
            color: iconColor,
            size: 20,
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${transaction.category} • ${_formatDate(transaction.createdAt)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${transaction.isExpense ? '-' : '+'}${transaction.amount.toStringAsFixed(2)} ₽',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              transaction.type.displayName,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () => onToggle(transaction.id),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}