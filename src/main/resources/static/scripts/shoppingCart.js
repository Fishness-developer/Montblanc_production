

document.addEventListener('DOMContentLoaded', () => {
    const cartItemContainer = document.querySelector("[data-items]");
    const buttonOrder = document.querySelector("[data-order-send]");
    const cartAmountTotal = document.querySelector("[data-order-price]");
    let productArray = [];
    let sum = 0.00;
    cartAmountTotal.textContent = sum.toFixed(2);

    // Function update localStorage
    const updateStorage = () => {
        const pattern = cartItemContainer.innerHTML.trim();
        pattern.length ? localStorage.setItem("products", pattern) : localStorage.removeItem("products");
    };

    // Function create cart from localStorage
    const createShoppingCart = () => {
        cartItemContainer.innerHTML = localStorage.getItem("products") || '';
        amountTotalStorage();
    };

    // Function calculate total amount from localStorage
    const amountTotalStorage = () => {
        document.querySelectorAll(".cart-order-product").forEach(e => {
            const price = Number(e.querySelector("[data-price]").textContent);
            const value = Number(e.querySelector("[data-val]").textContent);
            amountTotal(price * value);
        });
    };

    // Function update total amount
    const amountTotal = (amount) => {
        sum += amount;
        cartAmountTotal.textContent = sum.toFixed(2);
    };

    createShoppingCart();
    cartItemContainer.addEventListener('click', (e) => {
        if (e.target.closest('.cart-close')) {
            const cartProduct = e.target.closest('.cart-order-product');
            const priceClear = parseFloat(cartProduct.querySelector("[data-price]").textContent);
            const valClear = parseInt(cartProduct.querySelector("[data-val]").textContent, 10);
            cartProduct.remove();
            amountTotal(-priceClear * valClear);
            updateStorage();
        }
    });

    //VALIDATION FORM
    class FormValidation {
        selectors = {
            form: '[data-js-form]',
            fieldErrors: '[data-js-form-fields-error]'
        }

        errorMessages = {
            valueMissing: 'Please, input value',
            patternMismatch: 'Invalid format',
            tooShort: 'Too short value'
        }

        constructor() {
            this.bindEvents()
        }

        manageErrors(fieldControlElement, errorMessage) {
            const fieldErrorsElements = fieldControlElement.parentElement.querySelector(this.selectors.fieldErrors)
            fieldErrorsElements.innerHTML = errorMessage
                .map((message) =>
                    `<span>${message}</span>`).join('')
        }

        validateFields(fieldControlElement) {
            const errors = fieldControlElement.validity
            const errorMessages = []
            Object.entries(this.errorMessages).forEach(([errorType, errorMessage]) => {
                if (errors[errorType]) {
                    errorMessages.push(errorMessage)
                }
            })
            // console.log(fieldControlElement)
            this.manageErrors(fieldControlElement, errorMessages)
        }

        onBlur(e) {
            const isFormField = e.target.closest(this.selectors.form)
            const required = e.target.required
            if (isFormField && required) {
                this.validateFields(e.target)
            }
        }

        bindEvents() {
            document.addEventListener("blur", (e) => {
                this.onBlur(e)
            }, true)
        }
    }

    new FormValidation();
    function validationControl() {
        document.querySelectorAll('[data-input-order-field]').forEach((e) => {

        })
    }

    // Processor for sending order
    buttonOrder.addEventListener('click', (e) => {
        let allValid = true;
        document.querySelectorAll("[data-input-order-field]").forEach(e => {
            if (!e.validity.valid) {
                allValid = false
                return
            }
        })
        if (allValid) {
            buttonOrder.innerHTML = '<h3>Sending...</h3>';
            const radioGroup1 = document.querySelector('input[name="radio_1"]:checked')?.value;
            const radioGroup2 = document.querySelector('input[name="radio_2"]:checked')?.value;
            let personName = document.getElementById("name").value
            let personEmail = document.getElementById("email").value
            let personAddress = document.getElementById("address").value
            let personPhone = document.getElementById("phone").value
            let personComment = document.getElementById("comment").value
            let totalPrice = document.querySelector("[data-order-price]").textContent;

            document.querySelectorAll(".cart-order-product").forEach(e => {
                let obj = {}
                obj.image = e.querySelector(".cart-image img").src
                obj.name = e.querySelector("[data-name]").textContent
                obj.price = Number(e.querySelector("[data-price]").textContent)
                obj.value = Number(e.querySelector("[data-val]").textContent)
                productArray.push(obj)
            })

            fetch("./order", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    name: personName,
                    email: personEmail,
                    address: personAddress,
                    phone: personPhone,
                    comment: personComment,
                    delivery: radioGroup1,
                    payment: radioGroup2,
                    total: totalPrice,
                    products: productArray
                })
            })

                .then(r => r.text())
                .then(data => {
                    console.log(data)

                    function showModal() {
                        document.querySelector("[data-modal-succsess]").classList.toggle("hide")
                    }
                    showModal()
                    setTimeout(() => {
                        window.location.href = 'index.html';
                        localStorage.removeItem('products');
                    }, 3000)
                })
        }
    })

});