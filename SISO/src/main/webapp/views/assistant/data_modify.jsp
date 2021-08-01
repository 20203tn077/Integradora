<html>

<head>
    <title>SISO</title>
    <link href="/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/assets/css/customcolors.css" rel="stylesheet">
    <style>
        .feather {
            width: 16px;
            height: 16px;
            stroke: currentColor;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
            fill: none;
            position: relative;
            top: -2.5;
        }

        .btn-floating {
            position: fixed;
            bottom: 5rem;
            right: 5rem;
        }
    </style>
</head>

<body class="bg-light bg-gradient">
    <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
        <div class="container-fluid">
            <a class="navbar-brand" href="./login.html">Sistema de Seguimiento a Oficios</a>
        </div>
    </nav>
    <div class="container mt-4">
        <div class="card shadow-sm">
            <h5 class="card-header">Modificar datos</h5>
            <div class="card-body">
                <form action="" method="get">
                    <div class="row ">
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Nombre de usuario:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Nombre(s):</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Primer apellido:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Segundo apellido:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Correlo electrónico:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Contraseña:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Confimar contraseña:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button class="btn btn-verde ">
                                <svg class="feather">
                                    <use xlink:href="/assets/icons/feather-sprite.svg#check"/>
                                </svg>
                                Guardar cambios
                            </button>
                            <button class="btn btn-secondary">
                                Cancelar
                            </button>
                        </div>
                    </div>
                </form>

            </div>
        </div>

    </div>
    <script src="/assets/bootstrap/js/bootstrap.bundle.js"></script>
</body>

</html>