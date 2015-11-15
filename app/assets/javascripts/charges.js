(function(){
  'use strict';

  $(document).ready(initialize);

  // From Stripe. Prevent errors.
  if(typeof(StripeCheckout) == 'undefined'){
    var handler;
    console.log('Stripe having an issue.');
  } else {
    var handler = StripeCheckout.configure({token: cardValidated});
  }


  function initialize(){
    $('#buy-tickets-button').click(buyTickets);
    // Close Checkout on page navigation
    $(window).on('popstate', function() {
      handler.close();
    });
  }

  function buyTickets(event){
    tryptGlow();
    event.preventDefault();
    // Open Checkout with further options
    var eventName = $('#tickets-title').text();
    var eventQuantity = $('#tickets-quantity').val();
    var eventPrice = $('#tickets-price').text();
    var purchaseDescription = eventQuantity.toString() + ' tickets @ ' + eventPrice;
    var purchaseAmount = (parseFloat(eventQuantity) * parseFloat(eventPrice.split('$')[1])) * 100;
    handler.open({
      name: eventName,
      description: purchaseDescription,
      amount: purchaseAmount,
      image: $('.event-edit-flyer > img').attr('src'),
      key: $('#buy-tickets-button').attr('data-key')
    });
  }

  function cardValidated(token){
    var $form = $('#new-charge');
    var eventQuantity = $('#tickets-quantity').val();
    var eventPrice = $('#tickets-price').text();
    var purchaseAmount = (parseFloat(eventQuantity) * parseFloat(eventPrice.split('$')[1])) * 100;
    var eventId = $('#buy-tickets-button').attr('data-event-id');
    $form.append($('<input type="hidden" name="stripeToken" />').val(token.id));
    $form.append($('<input type="hidden" name="email" />').val(token.email));
    $form.append($('<input type="hidden" name="lastfour" />').val(token.card.last4));
    $form.append($('<input type="hidden" name="amount" />').val(purchaseAmount));
    $form.append($('<input type="hidden" name="event-id" />').val(eventId));
    $form.append($('<input type="hidden" name="quantity" />').val(eventQuantity));
    $form.submit();
  }

  function tryptGlow(){
    $('[class^="trypt-bright"]').animate({'opacity': '1'}, 1500);
  }

})();
