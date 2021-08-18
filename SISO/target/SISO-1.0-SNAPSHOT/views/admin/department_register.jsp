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
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <nav class="navbar-nav">
                    <a class="nav-link" href="${context}/Gestión_de_Usuarios?redirect=users">Gestión de usuarios</a>
                    <a class="nav-link active" href="${context}/Gestión_de_Departamentos?redirect=departments">Gestión de departamentos</a>
                    <a class="nav-link" href="${context}/Perfil?redirect=profile">Perfil</a>
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
            <h5 class="card-header">Nuevo departamento</h5>
            <div class="card-body">
                <form action="${context}/Gestión_de_Departamentos" method="POST" class="m-0" id="mainForm">
                    <input type="hidden" name="action" value="registerDepartment">
                    <div class="row gy-3">
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Nombre:</label>
                            <input type="text" class="form-control" id="nameInput" name="nameInput" autocomplete="off" maxlength="80" required>
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Descripción:</label>
                            <input type="text" class="form-control" id="descriptionInput" name="descriptionInput" autocomplete="off" maxlength="120" required>
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Número de teléfono:</label>
                            <input type="tel" class="form-control" id="phoneInput" name="phoneInput" pattern="[0-9]{10}" autocomplete="off" maxlength="10" required>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-footer bg-white">
                <div class="row">
                    <div class="p-1 col-md-4 col-xl-2">
                        <button type="button" class="btn btn-secondary w-100" data-bs-toggle="modal" data-bs-target="#modalExit">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                            </svg>
                            <span> Cancelar</span>
                        </button>
                    </div>
                    <div class="p-1 col-md-4 col-xl-3">
                        <button type="submit" class="btn btn-verde w-100" id="submitButton" form="mainForm">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#check" />
                            </svg>
                            <span> Registrar departamento</span>
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
                    <h5 class="modal-title">Descartar registro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col">
                            <p>¿Desea descartar el registro del nuevo departamento?</p>
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
                                <a class="btn btn-danger w-100" href="${context}/Gestión_de_Departamentos?redirect=departments">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#trash-2" />
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
        document.getElementById("nameInput").oninput = () => {
            if (document.getElementById("nameInput").value.length > 0 && document.getElementById("nameInput").value.trim().length == 0) {
                document.getElementById("nameInput").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("nameInput").setCustomValidity("");
            }
        }
        document.getElementById("descriptionInput").oninput = () => {
            if (document.getElementById("descriptionInput").value.length > 0 && document.getElementById("descriptionInput").value.trim().length == 0) {
                document.getElementById("descriptionInput").setCustomValidity("El campo no puede quedar en blanco");
            } else {
                document.getElementById("descriptionInput").setCustomValidity("");
            }
        }
        document.getElementById("phoneInput").oninput = () => {
            if (document.getElementById("phoneInput").validity.patternMismatch) {
                document.getElementById("phoneInput").setCustomValidity("El número debe tener 10 dígitos sin espacios ni otros caracteres");
            } else {
                document.getElementById("phoneInput").setCustomValidity("");
            }
        }
    </script>
</body>

</html>