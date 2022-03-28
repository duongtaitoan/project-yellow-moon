<%--
    Document   : cart
    Created on : Nov 29, 2021, 8:04:05 AM
    Author     : toan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>Cart Page</title>
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
                top: 0;
                width: 100%;
                position: fixed;
                z-index: 99;
            }
            .alertSMS{
                margin-top: 8%;
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
            .btnCart{
                text-align: center;
                display: flex;
                width: 100% !important;
                height: 100% !important;
            }
        </style>
    </head>
    <body>
        <script
            src="https://www.paypal.com/sdk/js?client-id=ARHRlxxmmLSzPD0ZJQZFxsmfQdPaXYbXRmeaIio_LCFe9mEIM533gr583jlDbBxmciwKFvo-qHcYrGAa&disable-card=amex,jcb"> // Required. Replace YOUR_CLIENT_ID with your sandbox client ID.
        </script>
        <!--instance id to click top-->
        <div id="clickScrollTop">
        </div>
        <!--Navbar-->
        <nav class=" navTop navbar navbar-expand-lg navbar-light bg-light">
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

        <!--Alert message success or failed-->
        <div class="alertSMS">
            <c:if test="${not empty CHECK_OUT_MSG}">
                <div class="text-warning m-auto alert alert-light alert-dismissible fade show text-center col-5 mt-5 shadow p-3 mb-5 bg-white rounded">
                    <strong>Note:</strong> ${CHECK_OUT_MSG}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
        </div>

        <div class="shadow-lg p-3 bg-body rounded container w-100">
            <div class="mt-3 mb-3">
                <div class="text-justify">
                    <c:if test="${not empty USER}">
                        <h3><i class="fa-solid fa-cart-shopping"></i> Your Cart: ${USER}</h3>
                    </c:if>
                    <c:if test="${empty ROLE}">
                        <h3><i class="fa-solid fa-cart-shopping"></i> Your Cart</h3>
                    </c:if>
                </div>
            </div>
            <div class="wrapper-header">
                <div class="wrapper-content">
                    <c:choose>
                        <c:when test="${empty CART}">
                            <h3 class="text-center">Your cart is empty</h3>
                        </c:when>
                        <c:when test="${not empty CART}">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Cake Name</th>
                                        <th>Unit price</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${CART}" var="cake">
                                        <tr>
                                            <td>${cake.cakeName}</td>
                                            <td>
                                                <fmt:setLocale value = "vi_VN"/>
                                                <fmt:formatNumber value = "${cake.price}" type = "currency"/>
                                            </td>
                                            <td>
                                                <form action="MainController" method="POST">
                                                    <div class="row w-75">
                                                        <div class="col">
                                                            <input class="form-control" value="${cake.quantity}" type="number" min="1" step="1" placeholder="quantity" name="txtQuantity" required="">
                                                        </div>
                                                        <div class="col">
                                                            <input type="hidden" name="txtCakeID" value="${cake.cakeID}">
                                                            <button type="submit" name="btnAction" value="Update Cart" class="btn btn-outline-success">Update</button>
                                                        </div>

                                                    </div>
                                                </form>
                                            </td>
                                            <td>
                                                <fmt:setLocale value = "vi_VN"/>
                                                <fmt:formatNumber value = "${cake.price*cake.quantity}" type = "currency"/>
                                            </td>
                                            <c:set var="totalPrice" value="${totalPrice+(cake.price*cake.quantity)}"/>
                                            <td>
                                                <button onclick="setIdForDeleteModal(${cake.cakeID})" class="btn btn-outline-warning w-100" type="button" data-bs-toggle="modal" data-bs-target="#deleteModal">Remove Cake</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <c:if test="${not empty CART}">
                <div class="wrapper mt-3">
                    <div class="wrapper-content">
                        <div class="form-group d-flex justify-content-between">
                            <div class="col">
                                Payment
                            </div>
                            <div class="col text-center">
                                <p>Total price:
                                    <fmt:setLocale value = "vi_VN"/>
                                    <fmt:formatNumber value = "${totalPrice}" type = "currency"/>
                                </p>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <button onclick="setPaymentModal()" class="btn btn-outline-dark w-100" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal">Confirm</button>
                                </div>
                                <div class="col">
                                    <div id="paypal-button-container">
                                        <form id="CheckOutPaypal" action="MainController" method="POST">
                                            <input type="hidden" name="paymentMethod" value="paypal"/>
                                            <input type="hidden" name="paymentStatus" value="paid"/>
                                            <input type="hidden" name="txtTotalPrice" value="${totalPrice}"/>
                                            <input type="hidden" name="btnAction" value="Check Out Paypal">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Deleting cake</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you want to delete this cake ?
                        </div>
                        <div class="modal-footer">
                            <form action="MainController" method="POST">
                                <input type="hidden" id="deleteCakeID" name="txtCakeID">
                                <button type="submit" name="btnAction" value="Remove From Cart" class="btn btn-danger">Remove</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Input your information</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="MainController" method="POST">
                                <div class="form-group">
                                    <label>Full Name</label>
                                    <c:if test="${not empty USER}">
                                        <input type="hidden" value="${USER}" name="txtName" class="form-control">
                                        <input type="text" disabled="disabled" value="${USER}" class="form-control">
                                    </c:if>
                                    <c:if test="${empty USER}">
                                        <input type="text" placeholder="FullName ex:(Dương Tài Toàn)" name="txtName" required="" class="form-control">
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <label>Phone number</label>
                                    <input type="tel" placeholder="Phone number ex:(0832434244)" pattern="[0]{1}[0-9]{9}" name="txtPhoneNumber" required="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" placeholder="Address ex: (234 Phạn Văn Hớn)" name="txtAddress" required="" class="form-control">
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="paymentMethod" value="payment upon delivery"/>
                                    <input type="hidden" name="paymentStatus" value="unPaid"/>
                                    <input type="hidden" name="txtTotalPrice" value="${totalPrice}"/>
                                    <button type="submit" name="btnAction" value="Check Out" class="btn btn-dark">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
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
                function setIdForDeleteModal(cakeID) {
                    document.getElementById("deleteCakeID").value = cakeID;
                }
                paypal.Buttons({
                    style: {
                        layout: 'horizontal',
                        fundingicons: 'true',
                        color: 'white',
                        shape: 'rect',
                        label: 'paypal',
                        height: 35,
                    },
                    funding: {
                        allowed: [paypal.FUNDING.CARD],
                        disallowed: [paypal.FUNDING.CREDIT]
                    },
                    createOrder: function (data, actions) {
                        return actions.order.create({
                            purchase_units: [{
                                    amount: {
                                        currency_code: 'USD',
                                        value: '${totalPrice}'
                                    }
                                }]
                        });
                    },
                    onApprove: function (data, actions) {
                        return actions.order.capture().then(function (details) {
                            alert('Payment completed !!!!');
                            document.getElementById("CheckOutPaypal").submit();
                        });
                    }
                }).render('#paypal-button-container');

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
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
    </body>
</html>
