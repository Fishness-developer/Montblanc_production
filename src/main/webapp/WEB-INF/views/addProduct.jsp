<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="E-shop of italian quality products">
    <link rel="apple-touch-icon" sizes="180x180" href="images/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
    <title>Mont Blanc</title>
    <link href="styles/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<header class="header">
    <div class="header__inner">
        <a class="header__logo logo" href="/"> <img class="logo__image" src="./images/Logo.png" alt="Mont Blanc"
                                                    width="250" height="84"/> </a>
        <div class="header__menu services">
            <ul></ul>
        </div>
        <div class="header__contact phone">
            <p class="tel">050 145-28-41</p>
            <p class="time">support 0800 574 54 44 </p>
        </div>
        <div class="header__contact time">
            <p class="tel">Store Opening</p>
            <p class="time">daily from 8.00 to 21.00 </p>
        </div>
    </div>
</header>
<nav class="nav">
    <ul class="nav__menu">
        <li class="nav__menu-item"><a href="/adminPanel">main page</a></li>
        <li class="nav__menu-item"><a href="/allOrders">orders</a></li>
        <li class="nav__menu-item"><a href="/addProduct">products</a></li>
        <li class="nav__menu-item"><a href="/">exit</a></li>
    </ul>
</nav>
<main>
    <section class="section_01">
        <div class="section_01__header_container">
            <h2>Admin Panel</h2>
        </div>
        <div class="section_01__shopping-cart-container">
            <div class="order_payment">
                <h4>Add Product</h4>
                <div class="orders_container">
                    <div class="form-container">
                        <form id="addProductForm" action="/addProduct" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="name">Product Name:</label>
                                <input type="text" id="name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="price">Price (₪):</label>
                                <input type="text" id="price" name="price" required>
                            </div>
                            <div class="form-group">
                                <label for="image">Product Image:</label>
                                <input type="file" id="image" name="image" accept="image/*" required>
                            </div>
                            <button type="submit" id="refreshTable">Add Product</button>
                        </form>

                        <div id="messageContainer"></div> <!-- Контейнер для сообщений -->

                        <c:if test="${not empty success}">
                            <p class="message">${success}</p>
                        </c:if>
                        <c:if test="${not empty error}">
                            <p class="error">${error}</p>
                        </c:if>
                    </div>
                </div>
                <div class="cart-item-container" data-items="">
                    <h3>Product List</h3>
                    <c:forEach var="product" items="${products}">
                        <div class="cart-order-product add-product" data-product-div>
                            <div class="grid-item" data-id="${product.id}">${product.id}</div>
                            <div class="cart-image grid-item"><img src="data:image/png;base64,${product.image}"
                                                                   class="product-image" alt="${product.name}"/></div>
                            <p class="grid-item" data-name>${product.name}</p>
                            <p class="grid-item"><span data-price>${product.price}</span> ₪</p>
                            <div class="cart-close grid-item" data-close><img src="images/svg/close.svg"/></div>

                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
    <section class="section_04">
        <div class="section_04__container">
            <div class="section_04__container phone"><span class="black">phone:</span> 050 145-28-41</div>
            <div class="section_04__container email"><span class="black">e-mail:</span> info@montblank.com</div>
            <div class="section_04__container support"><span class="black">support:</span> support@montblank.com</div>
        </div>
    </section>
</main>
<footer class="footer">
    <div class="footer__container">
        <div><img src="images/Logo.png" width="250" height="84" alt=""/>
            <p class="tel">050 145-28-41</p>
            <p class="time">daily from 8.00 to 21.00 </p>
        </div>
        <div>
            <h5>For buyers</h5>
            <ul>
                <li class="header__menu-item"><a href="/">Brand </a></li>
                <li class="header__menu-item"><a href="/">Recipes </a></li>
                <li class="header__menu-item"><a href="/">How to order</a></li>
                <li class="header__menu-item"><a href="/">Return of goods </a></li>
                <li class="header__menu-item"><a href="/">Loyalty program</a></li>
            </ul>
        </div>
        <div>
            <h5>information</h5>
            <ul>
                <li class="header__menu-item"><a href="/">Delivery and payment </a></li>
                <li class="header__menu-item"><a href="/">Contacts and details</a></li>
                <li class="header__menu-item"><a href="/">Privacy policy</a></li>
                <li class="header__menu-item"><a href="/">Consent to data processing </a></li>
            </ul>
        </div>
        <div>
            <h5>We accept payment</h5>
            <img src="images/payment.webp" width="170" alt=""/>
        </div>
    </div>
</footer>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("addProductForm");
        const messageContainer = document.getElementById("messageContainer");

        form.addEventListener("submit", function (e) {
            e.preventDefault();
            const formData = new FormData(this);

            fetch("/addProduct", {
                method: "POST",
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    messageContainer.innerHTML = "";
                    const message = document.createElement("p");
                    message.textContent = data.message;
                    message.className = data.status === "success" ? "message" : "error";
                    messageContainer.appendChild(message);
                    setTimeout(() => location.reload(), 1000)
                })
                .catch(error => {
                    messageContainer.innerHTML = `<p class="error">Error: ${error.message}</p>`;
                });

        });
    });


    document.querySelectorAll('[data-close]').forEach(closeButton => {
        closeButton.addEventListener("click", function () {
            const productDiv = closeButton.closest('.cart-order-product');
            if (!productDiv) {
                return;
            }

            const idElement = productDiv.querySelector('[data-id]');
            if (!idElement) {
                return;
            }

            const productId = idElement.getAttribute('data-id');

            const formData = new FormData();
            formData.append('id', productId);

            const messageContainer = document.getElementById("messageContainer");

            fetch("/deleteProduct", {
                method: "POST",
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    messageContainer.innerHTML = "";
                    const message = document.createElement("p");
                    message.textContent = data.message;
                    message.className = data.status === "success" ? "message" : "error";
                    messageContainer.appendChild(message);
                    if (data.status === "success") {
                        productDiv.remove();
                    }
                    setTimeout(() => location.reload(), 1000)
                })
                .catch(error => {
                    messageContainer.innerHTML = `<p class="error">Error: ${error.message}</p>`;
                });
        });
    });

</script>

</body>
</html>