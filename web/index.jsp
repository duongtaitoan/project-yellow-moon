<%--
    Document   : index
    Created on : Nov 29, 2021, 8:03:16 AM
    Author     : toan
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf8" />
        <link href="style.css" rel="stylesheet">
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

        <title>Index Page</title>
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
            .btnLogInAndOut .navbar-brand{
                transition: transform .5s;
                color: buttonshadow !important;
            }
            .btnLogInAndOut .navbar-brand:hover{
                color: black !important;
            }
            .dropdown-item {
                background-color: white !important;
            }
            .dropdown-item:hover{
                background-color: gray !important;
            }
            #table_cake .tableCake{
                text-align: center;
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
            <c:choose >
                <c:when test="${not empty ADD_TO_CART_MSG || not empty CREATE_CAKE_MSG_SUCCESS || not empty UPDATE_CAKE_MSG_SUCCESS || not empty ORDER_MSG || not empty CHECK_OUT_MSG}">
                    <div class="text-success m-auto alert alert-light alert-dismissible fade show text-center col-5 mt-5 shadow p-3 mb-5 bg-white rounded">
                        <strong>Note:</strong> ${ADD_TO_CART_MSG} ${DELETE_MSG} ${CREATE_CAKE_MSG_SUCCESS} ${ORDER_MSG} ${UPDATE_CAKE_MSG_SUCCESS} ${CHECK_OUT_MSG}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:when>
                <c:when test="${not empty CREATE_CAKE_MSG_FAILED || not empty UPDATE_CAKE_MSG_FAILED || not empty CHECK_LOGIN}">
                    <div class="text-warning m-auto alert alert-light alert-dismissible fade show text-center col-5 mt-5 shadow p-3 mb-5 bg-white rounded">
                        <strong>Note:</strong> ${CREATE_CAKE_MSG_FAILED} ${UPDATE_CAKE_MSG_FAILED} ${CHECK_LOGIN}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:when>
            </c:choose>
        </div>

        <!--local search find data-->
        <div class="container mt-5 shadow-lg p-3 bg-body rounded">
            <div class="text-justify">
                <c:if test="${not empty USER}">
                    <h3>Welcome to Yellow Moon Shop - ${USER}</h3>
                </c:if>
            </div>
            <div class="wrapper mt-2">
                <div class="wrapper-header">
                    <p>SEARCH PRODUCT</p>
                </div>
                <div class="wrapper-content">
                    <form action="MainController" method="POST">
                        <div class="row">
                            <div class="col-8">
                                <div class="form-group">
                                    <label>Name</label>
                                    <input class="form-control" type="text" name="txtCakeName" value="${searchedCakeName}" placeholder="Search cakes by name">
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label>Category</label>
                                    <select name="selectCategory" class="form-control">
                                        <option class="dropdown-menu" value="0">SELECT CATEGORY</option>
                                        <c:forEach items="${LIST_CATEGORY}" var="category">
                                            <option class="dropdown-item" value="${category.categoryID}" ${category.getCategoryID() == searchedCategoryID ? 'selected' : ''}>${category.category}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-4">
                                <div class="form-group">
                                    <label>From</label>
                                    <input class="form-control" type="number" value="${searchedPriceFrom}" min="1000" step="1000" name="txtPriceFrom" placeholder="From price">
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label>To</label>
                                    <input class="form-control" type="number" value="${searchedPriceTo}" min="1000" step="1000" name="txtPriceTo" placeholder="To price">
                                </div>
                            </div>
                            <div class="col-4 d-flex align-items-end">
                                <div class="w-100">
                                    <button class="btn w-100 btn btn-outline-dark" name="btnAction" value="Search Cake">Search</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--data table-->
        <c:if test="${LIST_CAKE != null}">
            <c:if test="${not empty LIST_CAKE}">
                <c:set var="context" value="${pageContext.request.contextPath}" />
                <div class="mt-5 mb-5 shadow-lg p-3 bg-body rounded container">
                    <table id="table_cake" class="table table-hover">
                        <!--column title of table-->
                        <thead>
                            <tr class="col text-center">
                                <th style="width: 14%">Cake Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Description</th>
                                <th>Category</th>
                                <th style="width: 100px">Create Date</th>
                                <th style="width: 130px">Expiration Date</th>
                                    <c:if test="${ROLE == 'ADMIN'}">
                                    <th>Quantity</th>
                                    <th>Status</th>
                                    </c:if>

                                <th style="width: 13%">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!--use foreach to show data-->
                            <c:forEach items="${LIST_CAKE}" var="cakes">
                                <c:if test="${ROLE == 'ADMIN'}">
                                    <tr class="tableCake">
                                        <td>${cakes.cakeName}</td>
                                        <td><img src="${context}/${cakes.image}" style="width: 150px;"></td>
                                        <td>
                                            <fmt:setLocale value = "vi_VN"/>
                                            <fmt:formatNumber value = "${cakes.price}"/>
                                        </td>
                                        <td>${cakes.description}</td>
                                        <td>${cakes.category}</td>
                                        <td>${cakes.createDate}</td>
                                        <td>${cakes.expirationDate}</td>
                                        <td>${cakes.quantity}</td>
                                        <td>
                                            <c:if test="${cakes.status == true}">
                                                <p>visible</p>
                                            </c:if>
                                            <c:if test="${cakes.status != true}">
                                                <p>invisible</p>
                                            </c:if>
                                        </td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <input name="txtCakeID" type="hidden" value="${cakes.cakeID}">
                                                <div class="row">
                                                    <div class="col">
                                                        <button type="submit" name="btnAction" value="Go To Update Page" class="btn w-100 btn-lg btn-outline-dark">Update</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                                <!--check role if user then show button add to cart-->
                                <c:if test="${cakes.status == true && ROLE != 'ADMIN'}">
                                    <tr>
                                        <td>${cakes.cakeName}</td>
                                        <td><img src="${context}/${cakes.image}" style="width: 150px;"></td>
                                        <td>
                                            <fmt:setLocale value = "vi_VN"/>
                                            <fmt:formatNumber value = "${cakes.price}"/>
                                        </td>
                                        <td>${cakes.description}</td>
                                        <td>${cakes.category}</td>
                                        <td>${cakes.createDate}</td>
                                        <td>${cakes.expirationDate}</td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <div class="row m-auto">
                                                    <input type="hidden" name="txtRequirement" value="notCheckLogin">
                                                    <input type="hidden" name="txtCakeID" value="${cakes.cakeID}">
                                                    <button type="submit" name="btnAction" value="Add To Cart" class="btn w-100 btn-lg btn-outline-dark">Add to cart</button>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${empty LIST_CAKE}">
                <h3 class="text-black text-center mt-5">Not found cakes <i class="fa-solid fa-face-frown-open"></i></h3>
                </c:if>
            </c:if>

        <!-- Scroll to top button -->
        <footer class="d-flex justify-content-end">
            <button class="btn btn-outline-light" id="scrollToTop" title="Go to top"><i class="fa-solid fa-circle-arrow-up"></i></button>
        </footer>

        <script>
//            use jquery to check paging
            $(document).ready(function () {
                $('#table_cake').DataTable({
                    "pageLength": 5,
                    "searching": false,
                    "bLengthChange": false
                });
            });
//            button logout
            document.getElementById("logoutLink").onclick = function () {
                document.getElementById("logoutForm").submit();
            };
//            lock user back page
            window.history.forward();
            function noBack() {
                window.history.forward();
            }
//            set time to alert hidden

            $(document).ready(function () {
                window.setTimeout(function () {
                    //fadeTo(speed, opacity)
                    $(".alert").fadeTo(800, 0).slideUp(1000, function () {
                        $(this).remove();
                    });
                }, 4000);
            });

            $(document).ready(function () {
                window.setTimeout(function () {
                    //fadeTo(speed, opacity)
                    $(".alertSMS .alert").fadeTo(800, 0).slideUp(1000, function () {
                        $(this).remove();
                    });
                }, 4000);
            });

            //Khi người dùng cuộn chuột thì gọi hàm scrollFunction
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
        <!--libraries of jquery to auto close alert message-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!--libraries of table-->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>
        <!--libraries of bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
    </body>
</html>
