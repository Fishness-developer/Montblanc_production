document.addEventListener("DOMContentLoaded", () => {
    fetch('/products')
        .then(r => r.json())
        .then(data => {
            const productSection = document.querySelector(".section_01__promotions");
            data.forEach(product => {
                productSection.innerHTML += `
                    <li class="section_01__promotions-item" data-product-name="${product.name}">
                        <a href="/">
                            <div class="item-image">
                                <img src="data:image/png;base64,${product.image}" alt="${product.name}"/>
                            </div>
                            <p class="price"><span class="extra">${product.price}</span> ₪</p>
                            <p class="item-description">${product.name}</p>
                        </a>
                        <div class="amount">
                            <button data-amount-decrease>-</button>
                            <input type="number" value="1" class="amount-input"/>
                            <button data-amount-increase>+</button>
                        </div>
                        <button class="section_01__promotions-item-button button" data-cart>add to cart</button>
                    </li>`;
            });

            // Adding quantity handlers
            const amount = document.querySelectorAll(".amount");
            amount.forEach((button) => {
                let counter = 1;
                button.addEventListener("click", (e) => {
                    if (e.target.textContent === "+") {
                        counter++;
                    } else if (e.target.textContent === "-" && counter > 1) {
                        counter--;
                    }
                    e.currentTarget.querySelector('.amount-input').value = counter;
                });
            });
        });

    // CART FUNCTIONS
    const amountProducts = document.querySelector("[data-amount]");
    const cartItemContainer = document.querySelector("[data-items]");
    const cartAmountTotal = document.querySelector(".cart-amount-total");

    let valNumber = 0;
    let sum = 0.00;
    amountProducts.textContent = valNumber;
    cartAmountTotal.textContent = sum.toFixed(2);

    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
        document.querySelector(".header__drop-cart-container").classList.add("flex");
        document.querySelector(".header__cart").classList.add("header__button-drop");
    }

    function updateCartVisibility() {
        const cartTotal = document.querySelector("[data-cart-total]");
        cartTotal.classList.toggle("hide", valNumber === 0);
        cartTotal.classList.toggle("flex", valNumber !== 0);
    }

    function sumItems(val) {
        valNumber += val;
        amountProducts.textContent = valNumber;
        updateCartVisibility();
    }

    function amountTotal(amount) {
        sum += amount;
        cartAmountTotal.textContent = sum.toFixed(2);
    }

    function amountTotalStorage() {
        document.querySelectorAll(".cart-order-product").forEach(e => {
            const price = Number(e.querySelector("[data-price]").textContent);
            const value = Number(e.querySelector("[data-val]").textContent);
            amountTotal(price * value);
        });
    }

    function sumItemsStorage() {
        document.querySelectorAll(".cart-order-product").forEach(e => {
            const value = Number(e.querySelector("[data-val]").textContent);
            sumItems(value);
        });
    }

    const updateStorage = () => {
        let pattern = cartItemContainer.innerHTML.trim();
        pattern.length ? localStorage.setItem("products", pattern) : localStorage.removeItem("products");
    };

    const initialStorage = () => {
        if (localStorage.getItem('products') !== null) {
            cartItemContainer.innerHTML += localStorage.getItem("products");
            amountTotalStorage();
            sumItemsStorage();
        }
    };
    initialStorage();

    // Delegating events for add to cart
    document.querySelector(".section_01__promotions").addEventListener('click', (e) => {
        const cartButton = e.target.closest('[data-cart]');
        if (cartButton) {
            const productItem = cartButton.closest('.section_01__promotions-item');
            const nameItem = productItem.querySelector('.item-description').textContent;
            const priceItem = parseFloat(productItem.querySelector('.extra').textContent);
            const imgItem = productItem.querySelector('.item-image img').src;
            const val = parseInt(productItem.querySelector('.amount-input').value);

            cartItemContainer.innerHTML += `
                <div class="cart-order-product">
                    <div class="cart-image"><img src="${imgItem}" /></div>
                    <p data-name>${nameItem}</p>
                    <p><span data-price>${priceItem.toFixed(2)}</span> ₪</p>
                    <div><span data-val>${val}</span> pcs</div>
                    <div class="cart-close"><img src="images/svg/close.svg" /></div>
                </div>`;
            sumItems(val);
            amountTotal(priceItem * val);
            updateStorage();
            scrollToTop();
        }
    });

    // Removing products from the cart
    cartItemContainer.addEventListener('click', (e) => {
        if (e.target.closest('.cart-close')) {
            const cartProduct = e.target.closest('.cart-order-product');
            const priceClear = parseFloat(cartProduct.querySelector("[data-price]").textContent);
            const valClear = parseInt(cartProduct.querySelector("[data-val]").textContent, 10);
            cartProduct.remove();
            amountTotal(-priceClear * valClear);
            sumItems(-valClear);
            updateStorage();
        }
    });

    // Toggle the visibility of the basket
    const buttonCart = document.querySelector(".header__cart");
    const buttonDropCart = document.querySelector(".header__drop-cart-container");
    buttonCart.addEventListener('click', () => {
        buttonDropCart.classList.toggle("flex");
        buttonCart.classList.toggle("header__button-drop");
    });
});