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
  <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
    <div class="container-fluid">
      <a class="navbar-brand" href="${context}/views/common/login.jsp">Sistema de Seguimiento a Oficios</a>
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
  <div class="container mt-5">
    <div class="row">
      <div class="col-md-7 col-xl-5 mx-auto">
        <div class="card shadow-sm">
          <h5 class="card-header">Restablecer contraseña</h5>
          <div class="card-body">
            <form action="${context}/Restablecer_Contraseña" method="POST" class="d-grid gap-3">
              <input type="hidden" name="action" value="newPasswordRequest">
              <div>
                <p>Ingresa el correo electrónico con el que se dió de alta
                  tu usuario.</p>
                <input type="email" class="form-control" name="emailInput" required>
              </div>
              <button type="submit" class="btn btn-verde">
                Recuperar contraseña
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="${context}/assets/js/bootstrap.bundle.js"></script>
</body>

</html>