function openCulqiCheckout(publicKey, amount, currency, email) {
  Culqi.publicKey = publicKey;
  Culqi.settings({
    title: 'MiCip',
    currency: currency,
    amount: amount,
  });
  Culqi.options({
    lang: 'es',
    installments: false,
  });
  Culqi.open();
}

function getCulqiToken(callback) {
  window.culqi = function () {
    if (Culqi.token) {
      callback(Culqi.token.id);
    } else {
      console.error("Error en Culqi:", Culqi.error);
    }
    Culqi.close();
  };
}