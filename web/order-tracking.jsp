<%--
    Document   : order-tracking
    Created on : Nov 30, 2021, 2:59:43 PM
    Author     : toan
--%>

<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <!--use lib of jquery-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
        <link rel="stylesheet" href="jquery.back-to-top.css">
        <!--jquery for scroll top button-->
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
        <script src="jquery.back-to-top.js"></script>
        <!--cdn of bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/9d281e3188.js" crossorigin="anonymous"></script>
        <!--icon of font awesome-->
        <link href="/your-path-to-fontawesome/css/fontawesome.css" rel="stylesheet">
        <link href="/your-path-to-fontawesome/css/brands.css" rel="stylesheet">
        <link href="/your-path-to-fontawesome/css/solid.css" rel="stylesheet">
        <title>Order Tracking</title>
        <style>
            *{
                scroll-behavior: smooth;
                font-family: cursive;
                margin: 0%;
                padding: 0%;
            }
            body{
                background-color:rgba(252,209,92,100);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
            }
            .navTop{
                top: 0px;
                width: 100%;
                position: fixed;
                z-index: 99;
            }
            .groupSearch{
                margin-top: 8% !important;
            }
            #scrollToTop {
                /* Mặc định button sẽ được ẩn*/
                display: none;
                position: fixed;
                bottom: 20px;
                right: 15px;
                height: 10%;
                width: 5%;
                font-size: 36px;
                /* button được ưu tiên hiển thị đè lên các phần khác*/
                z-index: 99;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 15px;
                border-radius: 10px;
            }
            #clickScrollTop{
                display: none;
                color: black;
            }
        </style>
    </head>
    <body>
        <div id="clickScrollTop">
        </div>
        <!--Navbar-->
        <nav class="navTop navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <div class="col-4 m-auto">
                    <ul class="navbar-nav my-lg-0 navbar-nav-scroll" style="max-height: 100px;">
                        <li class="nav-item col">
                            <a class="nav-link navbar" href="MainController">
                                <div class="nav-item col">
                                    <i class="fa-solid fa-house"></i>&nbsp;Home
                                </div>
                            </a>
                        </li>
                        <c:if test="${ROLE == 'ADMIN'}">
                            <li class="nav-item col">
                                <a class="nav-link" href="CreateCakeController">
                                    <i class="fa-solid fa-circle-plus"></i>
                                    New Cake
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${ROLE != 'ADMIN'}">
                            <li class="nav-item col">
                                <a title="Check Cart" class="nav-link" href="cart.jsp">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    Cart
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${ROLE == 'CUSTOMER'}">
                            <li class="nav-item row">
                                <a title="Check your order" class="nav-link" href="order-tracking.jsp">
                                    <i class="fa-solid fa-clipboard-check"></i>
                                    Order Tracking
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div class="form-inline my-2 my-lg-0 btnLogInAndOut">
                    <c:choose>
                        <c:when test="${empty ROLE}">
                            <a title="Login to page" class="navbar-brand" href="login.jsp">
                                <i class="fa-solid fa-right-to-bracket"></i>
                                Login
                            </a>
                        </c:when>
                        <c:when test="${not empty ROLE}">
                            <form id="logoutForm" action="MainController">
                                <input type="hidden" name="btnAction" value="Logout">
                                <a title="Logout to page" id="logoutLink" class="navbar-brand" href="#">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    Logout
                                </a>
                            </form>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </nav>

        <div class="groupSearch container mt-5 shadow-lg p-3 bg-body rounded">
            <div class="wrapper">
                <div class="wrapper-header">
                    <p>SEARCH</p>
                </div>
                <div class="wrapper-content">
                    <form method="POST" action="MainController" enctype="multipart/form-data">
                        <div class="form-group row">
                            <div class="col-9">
                                <label>Search by order id</label>
                                <input type="number" value="${txtOrderID}" name="txtOrderID" class="form-control" placeholder="OrderID">
                            </div>
                            <div class="col-3 d-flex align-items-end">
                                <button name="btnAction" value="Order Tracking" class="btn btn-outline-dark w-100">Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <c:if test="${LIST_ORDER_TRACKING != null}">
            <c:if test="${not empty LIST_ORDER_TRACKING}">
                <div class="mt-5 mb-5 shadow-lg p-3 bg-body rounded container">
                    <div class="wrapper-content">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>User Name</th>
                                    <th>OrderID</th>
                                    <th>Order Date</th>
                                    <th>Payment Method</th>
                                    <th>Total</th>
                                    <th>Payment Status</th>
                                    <th>Shipping Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${LIST_ORDER_TRACKING}" var="order">
                                    <tr>
                                        <td>
                                            <c:if test="${order.fullName == null}">
                                                ${USER}
                                            </c:if>
                                            <c:if test="${order.fullName != null}">
                                                ${order.fullName}
                                            </c:if>
                                        </td>
                                        <td>${order.orderID}</td>
                                        <td>${order.date}</td>
                                        <td>${order.paymentMethod}</td>
                                        <td>
                                            <fmt:setLocale value = "vi_VN"/>
                                            <fmt:formatNumber value = "${order.totalPrice}" type = "currency"/>
                                        </td>
                                        <td>${order.paymentStatus}</td>
                                        <td>${order.shippingAddress}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="text-center">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="context" value="${pageContext.request.contextPath}" />
                                    <c:forEach items="${LIST_OF_CAKES}" var="listOfCakes">
                                        <tr>
                                            <td>
                                                <div class="form-group row">
                                                    <div class="col-6">
                                                        Cake Name: ${listOfCakes.cakeName}
                                                    </div>
                                                    <div class="col-6">
                                                        Amount : ${listOfCakes.quantity}
                                                    </div>
                                                </div>
                                                <img class="w-100" src="${context}/${listOfCakes.image}" style=" height: 300px;width:200px">
                                                <hr>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty LIST_ORDER_TRACKING}">
                <h3 class="text-black text-center mt-5">Not found order tracking <i class="fa-solid fa-face-frown-open"></i></h3>
                </c:if>
            </c:if>

    </div>
</div>
<!-- Scroll to top button -->
<footer class="d-flex justify-content-end">
    <button class="btn btn-outline-light" id="scrollToTop" title="Go to top"><i class="fa-solid fa-circle-arrow-up"></i></button>
</footer>
<script>
    document.getElementById("logoutLink").onclick = function () {
        document.getElementById("logoutForm").submit();
    };
    window.onscroll = function () {
        scrollFunction();
    };
    function scrollFunction() {
        // Kiểm tra vị trí hiện tại của thanh scroll so với nội dung trang
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            //nếu lớn hơn 100px thì hiện button
            document.getElementById("scrollToTop").style.display = "block";
        } else {
            //nếu nhỏ hơn 100px thì ẩn button
            document.getElementById("scrollToTop").style.display = "none";
        }
    }
    //gán sự kiện click cho button
    document.getElementById('scrollToTop').addEventListener("click", function () {
        //Nếu button được click thì nhảy về đầu trang
        var elementTop = document.getElementById('clickScrollTop');
        document.body.scrollTop = elementTop;
        document.documentElement.scrollTop = elementTop;
    });
</script>
</body>
</html>
