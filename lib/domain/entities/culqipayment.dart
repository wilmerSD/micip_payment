class Culqipayment {
  final bool succces;
  final String? object;
  final String? id;
  final int? creationDate;
  final int? amount;
  final int? amountRefunded;
  final int? currentAmount;
  final String? merchantMessage;
  final String? userMessage;

  Culqipayment({
    this.object,
    this.id,
    this.creationDate,
    this.amount,
    this.amountRefunded,
    this.currentAmount,
    required this.succces,
    this.merchantMessage,
    this.userMessage,
  });
}
