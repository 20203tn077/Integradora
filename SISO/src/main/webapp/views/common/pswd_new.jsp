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
          <div class="card shadow-sm">
            <h5 class="card-header">Restablecer contraseña</h5>
            <div class="card-body">
              <form action="${context}/Inicio_de_Sesión" method="POST" class="m-0" id="mainForm">
                <input type="hidden" name="action" value="passwordChange">
                <input type="hidden" name="recoveryId" value="${id}">
                <div class="row gy-3">
                  <div class="col-12">
                    <label class="form-label">Nueva contraseña:</label>
                    <input type="password" class="form-control" name="passwordInput" required autocomplete="off"
                      maxlength="30" minlength="8" id="passwordInput">
                  </div>
                  <div class="col-12">
                    <label class="form-label">Confirmar contraseña:</label>
                    <input type="password" class="form-control" name="passwordConfirmation" required autocomplete="off"
                      maxlength="30" minlength="8" id="passwordConfirmation">
                  </div>
                  <div class="col-12">
                    <button type="submit" class="btn btn-verde" id="submitButton" form="mainForm">
                      <svg class="feather">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#check" />
                    </svg>
                    <span> Guardar nueva contraseña</span>
                    </button>
                  </div>
                </div>
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
  <script>
    document.getElementById("passwordInput").oninput = () => {
      if (document.getElementById("passwordInput").value.length > 0 && document.getElementById("passwordInput").value.trim().length == 0) {
        document.getElementById("passwordInput").setCustomValidity("El campo no puede quedar en blanco");
      } else {
        document.getElementById("passwordInput").setCustomValidity("");
      }
      if (document.getElementById("passwordConfirmation").value != document.getElementById("passwordInput").value) {
        document.getElementById("passwordConfirmation").setCustomValidity("Ambas contraseñas deben coincidir");
      } else {
        document.getElementById("passwordConfirmation").setCustomValidity("");
      }
    }
  </script>
</body>

</html>