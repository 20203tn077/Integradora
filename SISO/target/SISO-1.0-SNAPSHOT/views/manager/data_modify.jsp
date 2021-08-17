<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>

<head>
    <title>SISO</title>
    <link href="${context}/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${context}/assets/css/util.css" rel="stylesheet">
</head>

<body class="bg-light">
    <c:if test="${access}">
        <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
            <div class="container-fluid">
                <span class="navbar-brand">Sistema de Seguimiento a Oficios</span>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <nav class="navbar-nav">
                        <a class="nav-link" href="${context}/Gestión_de_Oficios?redirect=records">Gestión de oficios</a>
                        <a class="nav-link" href="${context}/Gestión_de_Auxiliares?redirect=assistants">Gestión de auxiliares</a>
                        <a class="nav-link active" href="${context}/Perfil?redirect=profile">Perfil</a>
                    </nav>
                    <nav class="navbar-nav ms-auto">
                        <a class="nav-link active" href="${context}/Inicio_de_Sesión?redirect=login">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#log-out" />
                            </svg>
                            <span> Salir</span>
                        </a>
                    </nav>
                </div>
            </div>
        </nav>
        <c:if test="${message != null}">
            <c:if test="${messageType == 1}">
                <div class="alert alert-primary alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#info" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 2}">
                <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#check-circle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 3}">
                <div class="alert alert-warning alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-circle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 4}">
                <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </c:if>
        <div class="container mt-4">
            <div class="card shadow-sm">
                <h5 class="card-header">Modificar datos</h5>
                <div class="card-body">
                    <form action="${context}/Perfil" method="POST" class="m-0" id="mainForm">
                        <input type="hidden" name="action" value="modifyData">
                        <div class="row gy-3">
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Nombre de usuario:</label>
                                <input type="text" class="form-control" id="usernameInput" name="usernameInput" value="${user.nameUser}" autocomplete="off" maxlength="20" required>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Nombre(s):</label>
                                <input type="text" class="form-control" id="nameInput" name="nameInput" value="${user.name}" autocomplete="off" maxlength="25" required>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Primer apellido:</label>
                                <input type="text" class="form-control" id="lastname1Input" name="lastname1Input" value="${user.lastname1}" autocomplete="off" maxlength="25" required>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Segundo apellido:</label>
                                <input type="text" class="form-control" id="lastname2Input" name="lastname2Input" value="${user.lastname2}" autocomplete="off" maxlength="25">
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Correo electrónico:</label>
                                <input type="email" class="form-control" id="emailInput" name="emailInput" value="${user.email}" autocomplete="off" maxlength="60" required>
                            </div>
                        </div>
                        <hr>
                        <div class="row gy-3">
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Contraseña:</label>
                                <input type="password" class="form-control" id="passwordInput" name="passwordInput" autocomplete="off" maxlength="30" minlength="8">
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <label class="form-label">Confimar contraseña:</label>
                                <input type="password" class="form-control" id="passwordConfirmation" autocomplete="off" maxlength="30" minlength="8">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer bg-white">
                    <div class="row">
                        <div class="p-1 col-md-4 col-xl-3">
                            <button type="button" class="btn btn-secondary w-100" data-bs-toggle="modal" data-bs-target="#modalExit">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                                </svg>
                                <span> Cancelar</span>
                            </button>
                        </div>
                        <div class="p-1 col-md-4 col-xl-3">
                            <button class="btn btn-verde w-100" id="submitButton">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#check" />
                                </svg>
                                <span> Guardar cambios</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" tabindex="-1" id="modalExit">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Descartar cambios</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col">
                                <p>¿Desea descartar los cambios realizados?</p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row w-100">
                            <div class="p-1 col-md-6 col-lg-4">
                                <button class="btn btn-secondary w-100" data-bs-dismiss="modal">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                                    </svg>
                                    <span> Cancelar</span>
                                </button>
                            </div>
                            <div class="p-1 col-md-6 col-lg-4">
                                    <a class="btn btn-verde w-100" href="${context}/Perfil?redirect=profile">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#corner-up-left" />
                                        </svg>
                                        <span> Descartar</span>
                                    </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${! access}">
        <div class="alert alert-danger m-3">
            <svg class="feather-24">
                <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
            </svg>
            <span> Error: No tienes acceso a este sitio.</span>
        </div>
    </c:if>
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script>
        document.getElementById("submitButton").onclick = () => {
            if (document.getElementById("usernameInput").value.length > 0 && document.getElementById("usernameInput").value.trim().length == 0) {
                document.getElementById("usernameInput").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("usernameInput").setCustomValidity("");
            }
            if (document.getElementById("nameInput").value.length > 0 && document.getElementById("nameInput").value.trim().length == 0) {
                document.getElementById("nameInput").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("nameInput").setCustomValidity("");
            }
            if (document.getElementById("lastname1Input").value.length > 0 && document.getElementById("lastname1Input").value.trim().length == 0) {
                document.getElementById("lastname1Input").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("lastname1Input").setCustomValidity("");
            }
            if (document.getElementById("lastname2Input").value.length > 0 && document.getElementById("lastname2Input").value.trim().length == 0) {
                document.getElementById("lastname2Input").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("lastname2Input").setCustomValidity("");
            }
            if (document.getElementById("emailInput").value.length > 0 && document.getElementById("emailInput").value.trim().length == 0) {
                document.getElementById("emailInput").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("emailInput").setCustomValidity("");
            }
            if (document.getElementById("passwordInput").value.length > 0) {
                if (document.getElementById("passwordInput").value.trim().length == 0) {
                    document.getElementById("passwordInput").setCustomValidity("El campo no puede quedar en blanco");
                } else {
                    document.getElementById("passwordInput").setCustomValidity("");
                }
                document.getElementById("passwordConfirmation").required = true;
            } else {
                document.getElementById("passwordConfirmation").required = false;
                document.getElementById("passwordConfirmation").value = "";
            }
            if (document.getElementById("passwordConfirmation").value != document.getElementById("passwordInput").value) {
                document.getElementById("passwordConfirmation").setCustomValidity("Ambas contraseñas deben coincidir");
            } else {
                document.getElementById("passwordConfirmation").setCustomValidity("");
            }


            if (document.getElementById("mainForm").checkValidity()) {
                document.getElementById("mainForm").submit();
            } else {
                document.getElementById("mainForm").reportValidity();
            }
        }
    </script>
</body>

</html>