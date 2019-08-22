document.addEventListener('turbolinks:load', () => {
    const publishableKey = document.querySelector("meta[name='stripe-key']").content;
    const stripe = Stripe(publishableKey);

    const elements = stripe.elements({
        locale: 'auto'
    });

    const style = {
        base: {
            color: '#32325d',
            fontWeight: 500,
            fontSize: '18px',
            fontSmoothing: 'antialiased',

            '::placeholder': {
                color: '#CFD7DF'
            }
        },
        invalid: {
            color: '#E25950'
        }
    };

    const card = elements.create('card', { style });
    card.mount('#card-element');

    card.addEventListener('change', ( {error} ) => {
        const displayError = document.getElementById('card-errors');
        if(error) {
            displayError.textContent = error.message;
        } else {
            displayError.textContent = "";
        }
    });

    const form = document.getElementById('payment-form');

    form.addEventListener('submit', function(event) {
        event.preventDefault();

        stripe.createToken(card).then(function(result) {
            if (result.error) {
                // Inform the user if there was an error.
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = result.error.message;
            } else {
                // Send the token to server.
                stripeTokenHandler(result.token);
            }
        });
    });

    const stripeTokenHandler = (token) => {
        const form = document.getElementById('payment-form');
        const hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', token.id);
        form.appendChild(hiddenInput);

        ["brand", "last4", "exp_month", "exp_year"].forEach(function(field) {
            addCardField(form, token, field);
        });

        form.submit();
    }

    function addCardField(form, token, field) {
        let hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', "user[card_" + field + "]");
        hiddenInput.setAttribute('value', token.card[field]);
        form.appendChild(hiddenInput);
    }

});