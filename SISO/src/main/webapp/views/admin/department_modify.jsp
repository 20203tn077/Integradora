<html>

<head>
    <title>SISO</title>
    <link href="/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/assets/css/util.css" rel="stylesheet">
</head>

<body class="bg-light bg-gradient">
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
                    <a class="nav-link" href="/views/admin/user_list.html">Gestión de usuarios</a>
                    <a class="nav-link active" href="/views/admin/department_list.html">Gestión de departamentos</a>
                    <a class="nav-link" href="/views/admin/profile.html">Perfil</a>
                </nav>
                <nav class="navbar-nav ms-auto">
                    <a class="nav-link active" href="/views/common/login.html">
                        <svg class="feather">
                            <use xlink:href="/assets/icons/feather-sprite.svg#log-out" />
                        </svg>
                        <span> Salir</span>
                    </a>
                </nav>
            </div>
        </div>
    </nav>
    <div class="container mt-4">
        <div class="card shadow-sm">
            <h5 class="card-header">Modificar departamento</h5>
            <div class="card-body">
                <form action="" method="get">
                    <div class="row ">
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Nombre:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Descripción:</label>
                            <input type="text" class="form-control" id="usernameInput" required>
                        </div>
                        <div class="col-md-6 col-xl-4 mb-3">
                            <label for="usernameInput" class="form-label">Teléfono:</label>
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
    <div class="modal fade" tabindex="-1" id="attendedRecordModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del oficio</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Número de oficio:
                                </span>
                                <p id="modal2RecordId"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de canalización:
                                </span>
                                <p id="modal2ChannellingDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de asignación:
                                </span>
                                <p id="modal2AssignmentDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de respuesta:
                                </span>
                                <p id="modal2ResponseDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Departamento:
                                </span>
                                <p id="modal2Department"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Prioridad:
                                </span>
                                <p>
                                    <span id="modal2Priority"></span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Comentario:
                                </span>
                                <p id="modal2Comment"></p>
                            </div>
                        </div>
                        <div class="row">
                            <h5>Acciones:</h5>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <form action="/ServletRecords" method="POST" target="_blank" class="m-0">
                                    <input type="hidden" value="getRecordById" name="action">
                                    <input type="hidden" id="modal2RecordIdInput" name="recordIdInput">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="/assets/icons/feather-sprite.svg#file-text" />
                                        </svg>
                                        <span> Visualizar archivo</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/js/bootstrap.bundle.js"></script>
    <script src="/assets/js/assistant/recordListUtil.js"></script>
</body>

</html>