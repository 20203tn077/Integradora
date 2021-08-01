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
            <form action="asd" method="get" class="d-grid gap-3">
              <div>
                <label for="usernameInput" class="form-label">Ingresa el correo electrónico con el que se dió de alta
                  tu usuario. Se te enviará un token para poder validar tu identidad.</label>
                <input type="email" class="form-control" id="emailInput" required>
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