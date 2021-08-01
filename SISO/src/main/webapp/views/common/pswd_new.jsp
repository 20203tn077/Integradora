<html>

<head>
  <title>SISO</title>
  <link href="../assets/bootstrap/css/bootstrap.css" rel="stylesheet">
  <link href="../assets/css/customcolors.css" rel="stylesheet">
  <style>
    .feather {
      width: 16px;
      height: 16px;
      stroke: currentColor;
      stroke-width: 2;
      stroke-linecap: round;
      stroke-linejoin: round;
      fill: none;
    }
  </style>
</head>

<body class="bg-light bg-gradient">
  <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
    <div class="container-fluid">
      <a class="navbar-brand" href="./login.html">Sistema de Seguimiento a Oficios</a>
    </div>
  </nav>

  <div class="container mt-5">
    <div class="row">
      <div class="col-md-7 col-xl-5 mx-auto">
        <div class="card">
          <h5 class="card-header">Restablecer contraseña</h5>
          <div class="card-body">
            <form action="asd" method="get" class="d-grid gap-3">
              <div>
                <label for="usernameInput" class="form-label">Ingresa una nueva contraseña</label>
                <input type="text" class="form-control" id="tokenInput" required>
              </div>
              <div>
                <label for="usernameInput" class="form-label">Repite la contraseña</label>
                <input type="text" class="form-control" id="tokenInput" required>
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

  <script src="../assets/bootstrap/js/bootstrap.bundle.js"></script>
</body>

</html>