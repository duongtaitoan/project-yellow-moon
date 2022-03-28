<%--
    Document   : error
    Created on : Nov 29, 2021, 8:28:46 AM
    Author     : toan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <title>ERROR PAGE</title>
    </head>
    <body>
        <!--Navbar-->
        <nav class="navbar navbar-dark bg-dark navbar-expand-lg">
            <div class="container">
                <c:choose>
                    <c:when test="${empty ROLE}">
                        <a class="navbar-brand" href="login.jsp">Login</a>
                    </c:when>
                    <c:when test="${not empty ROLE}">
                        <form id="logoutForm" action="MainController">
                            <input type="hidden" name="btnAction" value="Logout">
                            <a id="logoutLink" class="navbar-brand" href="#">Logout</a>
                        </form>
                    </c:when>
                </c:choose>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="MainController">Home</a>
                        </li>
                        <c:if test="${ROLE == 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="CreateCakeController">New Cake</a>
                            </li>
                        </c:if>
                        <c:if test="${ROLE == 'CUSTOMER'}">
                            <li class="nav-item">
                                <a class="nav-link" href="cart.jsp">Cart</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <h2>${ERROR_MSG}</h2>
    </body>
</html>
