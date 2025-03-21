<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description"
          content="E-shop of italian quality products">
    <link rel="apple-touch-icon" sizes="180x180" href="images/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
    <title>Mont Blank</title>
    <script src="scripts/shoppingCart.js" defer></script>
    <link href="styles/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<header class="header">
    <div class="header__inner">
        <a class="header__logo logo" href="/"> <img class="logo__image" src="./images/Logo.png" alt="Mont Blank"
                                                    width="250" height="84"/> </a>
        <div class="header__menu services">
            <ul>
            </ul>
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
                <h4>all orders</h4>
                <div class="orders_container">
                    <table class="orders_print">
                        <tr>
                            <td>Order ID</td>
                            <td>Customer</td>
                            <td>Address</td>
                            <td>Phone</td>
                            <td>Time delivery</td>
                            <td>Payment</td>
                            <td>Comment</td>
                            <td>Total Price</td>
                            <td>Orders</td>
                            <td> </td>
                        </tr>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.id}</td>
                                <td>${order.name}</td>
                                <td>${order.address}</td>
                                <td>${order.phone}</td>
                                <td>${order.delivery}</td>
                                <td>${order.payment}</td>
                                <td>${order.comment}</td>
                                <td>${order.total}</td>
                                <td>
                                    <%-- Перебор продуктов внутри каждого заказа --%>
                                    <c:choose>
                                        <c:when test="${empty order.products}">
                                            No products
                                        </c:when>
                                        <c:otherwise>
                                            <ul>
                                                <c:forEach var="product" items="${order.products}">
                                                    <li>
                                                        <c:out value="${product.name}"/>
                                                        -
                                                        <c:out value="${product.price}"/>
                                                        ₪
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center; vertical-align: middle;">
                                    <div class="cart-close grid-item" data-close data-order-id="${order.id}"  onclick="deleteOrder('${order.id}')"><img src="images/svg/close.svg"/></div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
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
            <img src="images/payment.webp" width="170" alt=""/></div>
    </div>
</footer>
<script>
    function deleteOrder(orderId) {

            fetch('/deleteOrder/' + orderId, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
                .then(response => {
                    if (response.ok) {
                        const row = document.getElementById('order-' + orderId);
                        if (row) {
                            row.remove();

                        }
                    } else {
                        alert('Failed to delete order');
                    }
                    setTimeout(() => location.reload(), 100)
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error deleting order');
                });

    }
</script>
</body>
</html>