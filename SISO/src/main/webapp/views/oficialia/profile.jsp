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
                    <a class="nav-link" href="#">Gestión de oficios</a>
                    <a class="nav-link active" href="#">Perfil</a>
                </nav>
                <nav class="navbar-nav ms-auto">
                    <a class="nav-link active" href="/views/common/login.jsp">
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
            <h5 class="card-header">Perfil</h5>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p class="fw-bold m-0">
                            Nombre de usuario:
                        </p>
                        <p>
                            asdasdsa
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="fw-bold m-0">
                            Nombre:
                        </p>
                        <p>
                            Hermenegildo hermenegildo hermenegildez hermenegildez
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="fw-bold m-0">
                            Correo electrónico:
                        </p>
                        <p>
                            asdasdsa
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="fw-bold m-0">
                            Rol:
                        </p>
                        <p>
                            asdasdsa
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="fw-bold m-0">
                            Departamento:
                        </p>
                        <p>
                            asdasdsa
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col" height="1000px">
                        <button class="btn btn-verde">
                            <svg class="feather">
                                <use xlink:href="/assets/icons/feather-sprite.svg#edit" />
                            </svg>

                            Modificar datos

                        </button>
                    </div>
                </div>
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