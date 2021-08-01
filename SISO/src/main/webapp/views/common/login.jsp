<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>

<head>
    <title>SISO</title>
    <link href="${context}/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${context}/assets/css/util.css" rel="stylesheet">
</head>

<body class="bg-light bg-gradient">
    <div class="container mt-5">
        <div class="row">
            <h2 class="text-center">Sistema de Seguimiento a Oficios</h2>
        </div>
        <div class="row">
            <div class="col-md-7 col-xl-4 mx-auto">
                <div class="card shadow-sm">
                    <h5 class="card-header">Inicio de sesión</h5>
                    <div class="card-body">
                        <form action="${context}/ServletUsers" method="POST" class="d-grid gap-3">
                            <input type="hidden" value="access" name="action">
                            <div>
                                <label for="usernameInput" class="form-label">Nombre de usuario</label>
                                <input type="text" class="form-control" id="usernameInput"name="usernameInput" required>
                            </div>
                            <div>
                                <label for="passwordInput" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="passwordInput" name="passwordInput" required>
                                <div class="form-text">
                                    <a href="${context}/views/common/pswd_request.jsp" class="link-secondary">¿Olvidaste tu
                                        contraseña?</a>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-verde">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#log-in" />
                                </svg>
                                <span> Ingresar</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${context}assets//js/bootstrap.bundle.js"></script>
</body>

</html>