<%--
    Document   : update-cake
    Created on : Nov 29, 2021, 8:03:55 AM
    Author     : toan
--%>


<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
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
        <title>Update Cake</title>
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
            <c:if test="${not empty UPDATE_CAKE_MSG_FAILED}">
                <div class="text-warning m-auto alert alert-light alert-dismissible fade show text-center col-5 mt-5 shadow p-3 mb-5 bg-white rounded">
                    <strong>Note:</strong> ${UPDATE_CAKE_MSG_FAILED}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
        </div>

        <div class="d-flex justify-content-center shadow-lg p-3 bg-body rounded container w-50">
            <div class="wrapper w-75 mt-auto">
                <div class="wrapper-header text-center">
                    <div class="d-flex flex-col justify-content-center">
                        <p>
                            <i class="fa-solid fa-cookie"></i>
                            UPDATE CAKE (ID = ${CAKE_DETAIL.cakeID})
                        </p>
                    </div>
                </div>
                <div class="wrapper-content">
                    <form method="POST" action="MainController" enctype="multipart/form-data">
                        <input type="hidden" name="txtCakeID" value="${CAKE_DETAIL.cakeID}">
                        <div class="form-group mt-3">
                            <label>Cake name</label>
                            <input type="text" placeholder="Cake name" value="${CAKE_DETAIL.cakeName}" pattern="[^!@#$%^&*()_+]{0,}" name="txtCakeName" required="" class="form-control">
                        </div>
                        <div class="form-group mt-3">
                            <label>Price</label>
                            <input type="number" min="1000" step="1000" value="${CAKE_DETAIL.price}" name="txtPrice" placeholder="Price" required="" class="form-control">
                        </div>
                        <div class="form-group mt-3">
                            <label>Category</label>
                            <select name="selectCategory" class="form-control">
                                <option value="0">SELECT CATEGORY</option>
                                <c:forEach items="${LIST_CATEGORY}" var="category">
                                    <option value="${category.categoryID}" ${category.getCategoryID() == CAKE_DETAIL.categoryID ? 'selected' : ''}>${category.category}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group mt-3">
                            <label>Quantity</label>
                            <input type="number" value="${CAKE_DETAIL.quantity}" placeholder="Quantity" min="0" step="1" required="" name="txtQuantity" class="form-control">
                        </div>
                        <div class="form-group mt-3">
                            <label>Status</label>
                            <div id="main">
                                <select class="form-control" name="txtStatus">
                                    <c:if test="${CAKE_DETAIL.status == true}">
                                        <option value="true">visible</option>
                                        <option value="false">invisible</option>
                                    </c:if>
                                    <c:if test="${CAKE_DETAIL.status != true}">
                                        <option value="false">invisible</option>
                                        <option value="true">visible</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mt-3">
                            <label>Description</label>
                            <input type="text" value="${CAKE_DETAIL.description}" placeholder="Description" pattern="[^!@#$%^&*()_+]{0,}" name="txtDescription" class="form-control">
                        </div>
                        <div class="form-group mt-3">
                            <label>Create Date</label>
                            <input type="date" value="${CAKE_DETAIL.createDate}" required="" placeholder="Create Date" name="txtCreateDate" class="form-control" max="<%=LocalDate.now().minusDays(1)%>">
                        </div>
                        <div class="form-group mt-3">
                            <label>Expiration Date</label>
                            <input type="date" value="${CAKE_DETAIL.expirationDate}" required="" placeholder="Expiration Date" name="txtExpirationDate" class="form-control" min="<%=LocalDate.now().minusDays(-7)%>" >
                        </div>
                        <c:set var="context" value="${pageContext.request.contextPath}" />
                        <div class="form-group mt-3 img-thumbnail">
                            <img class="rounded mx-auto d-block" id="uploadPreview" src="${context}/${CAKE_DETAIL.image}" style="width: 50%; height: 35%;" />
                            <input id="uploadImage" type="file" name="inputImage" value="${image}" onchange="PreviewImage();" />
                        </div>
                        <div class="mt-5 btn d-flex justify-content-center">
                            <input class="btn w-75 btn-lg btn-outline-dark" type="submit" name="btnAction" value="Update Cake">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Scroll to top button -->
        <footer class="d-flex justify-content-end">
            <button class="btn btn-outline-light" id="scrollToTop" title="Go to top"><i class="fa-solid fa-circle-arrow-up"></i></button>
        </footer>

        <c:if test="${ROLE != 'ADMIN'}">
            <c:redirect url="index.jsp"/>
        </c:if>
        <script>
            document.getElementById("logoutLink").onclick = function () {
                document.getElementById("logoutForm").submit();
            };
        </script>
        <script type="text/javascript">

            function PreviewImage() {
                var oFReader = new FileReader();
                oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);

                oFReader.onload = function (oFREvent) {
                    document.getElementById("uploadPreview").src = oFREvent.target.result;
                };
            }
            ;
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
