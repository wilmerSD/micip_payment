class Token {
    final String? object;
    final String? id;
    final String? type;
    final String? email;
    final int? creationDate;
    final String? cardNumber;
    final String? lastFour;
    final bool? active;

    Token({
        this.object,
        this.id,
        this.type,
        this.email,
        this.creationDate,
        this.cardNumber,
        this.lastFour,
        this.active,
    });
}
