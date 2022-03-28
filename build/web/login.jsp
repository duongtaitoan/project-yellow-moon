<%--
    Document   : login
    Created on : Nov 29, 2021, 8:03:30 AM
    Author     : toan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <!--cdn of bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/9d281e3188.js" crossorigin="anonymous"></script>
        <!--icon of font awesome-->
        <link href="/your-path-to-fontawesome/css/fontawesome.css" rel="stylesheet">
        <link href="/your-path-to-fontawesome/css/brands.css" rel="stylesheet">
        <link href="/your-path-to-fontawesome/css/solid.css" rel="stylesheet">
        <title>Login page</title>
        <style>
            *{
                font-family: cursive;
                margin: 0%;
                padding: 0%;
            }
            .bgBody{
                height: 100%;
                background-color:rgba(252,209,92,100);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
            }
            .loginHover{
                margin: 0% -0.5%;
                margin-left: 25%;
                width: 50%;
                height: 80%;
                transition: transform .5s;
                color: buttonshadow;
            }
            .loginHover .backgroudLogin:hover{
                margin: 0% 0.5%;
                color: black;
            }
        </style>
    </head>
    <body class="bgBody">
        <c:if test="${not empty ROLE}">
            <c:redirect url="index.jsp"/>
        </c:if>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <ul class="navbar-nav my-lg-0 navbar-nav-scroll" style="max-height: 100px;">
                    <li class="nav-item">
                        <a class="nav-link navbar" href="MainController">
                            <div class="col">
                                <i class="fa-solid fa-house"></i>&nbsp;Home
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <c:if test="${LOGIN_MSG != null}">
            <div class="m-auto alert alert-light alert-dismissible fade show text-center col-5 mt-5">
                <strong style="color:red">Error!!!</strong> ${LOGIN_MSG}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="pt-5">
            <div class="container mt-3">
                <!--<div class="wrapper w-50 m-auto mt-5 p-30 shadow-lg p-3 mb-5 bg-body rounded">-->
                <!--<div class="m-auto w-50 wrapper shadow-lg p-3 bg-body rounded loginHover">-->
                <div class="wrapper shadow-lg p-3 bg-body rounded loginHover">
                    <div class="backgroudLogin">
                        <div class="text-center">
                            <h2 class="page-title text-center mt-3 bold">Yellow Moon shop</h2>
                        </div>
                        <div class="wrapper-content">
                            <form action="MainController" method="POST">
                                <div class="form-group mt-2">
                                    <i class="fa-solid fa-user"></i>
                                    <label >Username</label>
                                    <input type="text" class="form-control mt-2" name="txtUserID" placeholder="teo@gmail.com" required="">
                                </div>
                                <div class="form-group mt-2">
                                    <i class="fa-solid fa-key"></i>
                                    <label>Password</label>
                                    <input type="password" class="form-control mt-2" name="txtPassword" placeholder="*****" required="">
                                </div>
                                <div class="row mt-4">
                                    <div class="col-5 pl-2">
                                        <button value="Login" name="btnAction" type="submit" class="btn w-100 btn-lg btn-outline-dark">Login</button>
                                    </div>
                                    <div class="col-7">
                                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/LoginGoogleController&response_type=code&client_id=544796723217-p8qrf0ap0a3e4pq3ji5rf1f2d17cu04v.apps.googleusercontent.com&approval_prompt=force">
                                            <p class="btn w-100 btn-lg btn-outline-dark">
                                                <i class="fa-brands fa-google"></i>
                                                Login with google
                                            </p>
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--hidden alert auto 3s or user click to x-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                window.setTimeout(function () {
                    //fadeTo(speed, opacity)
                    $(".alert").fadeTo(800, 0).slideUp(1000, function () {
                        $(this).remove();
                    });
                }, 3000);

            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
