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
        <a class="navbar-brand" href="${context}/views/common/login.jsp">Sistema de Seguimiento a Oficios</a>
      </div>
    </nav>

    <div class="container mt-5">
      <div class="row">
        <div class="col-md-7 col-xl-5 mx-auto">
          <div class="card">
            <h5 class="card-header">Restablecer contraseña</h5>
            <div class="card-body">
              <form action="${context}/Inicio_de_Sesión" method="POST" class="d-grid gap-3">
                <input type="hidden" name="action" value="passwordChange">
                <input type="hidden" name="recoveryId" value="${id}">
                <div>
                  <label for="usernameInput" class="form-label">Ingresa una nueva contraseña</label>
                  <input type="password" class="form-control" name="passwordInput" required>
                </div>
                <div>
                  <label for="usernameInput" class="form-label">Repite la contraseña</label>
                  <input type="password" class="form-control" name="passwordConfirmation" required>
                </div>
                <button type="submit" class="btn btn-verde">
                  Cambiar contraseña
                </button>
              </form>
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
</body>

</html>