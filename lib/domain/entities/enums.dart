enum PaymentType {
  monthlyFees(0),       
  certificateskill(1),  
  proffnodebt(2),       
  advancepay(3);        

  final int code;
  const PaymentType(this.code);
}
extension PaymentTypeX on PaymentType {
  int toInt() => index;

  static PaymentType fromInt(int value) {
    return PaymentType.values[value];
  }
}

enum PaymentChannel {
  inPerson(0), //presencial
  online(1); //online

  final int code;
  const PaymentChannel(this.code);
}

enum ReceiptType {
  bill(0),    // boleta
  invoice(1); // factura

  final int code;
  const ReceiptType(this.code);
}

enum PlatformPayment {
  app(0),
  web(0), 
  caja(1);

  final int code;
  const PlatformPayment(this.code);
}