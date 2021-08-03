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
                    <a class="nav-link active" href="/views/admin/user_list.html">Gestión de usuarios</a>
                    <a class="nav-link" href="/views/admin/department_list.html">Gestión de departamentos</a>
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
            <h5 class="card-header">Gestión de usuarios</h5>
            <div class="card-body" height="100px">
                <div class="table-container">
                    <table class="table table-azul table-striped table-hover border text-center">
                        <thead class="thead-azul display-none">
                            <tr>
                                <th>Nombre de usuario</th>
                                <th>Nombre</th>
                                <th>Rol</th>
                                <th>Departamento</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr role="button">
                                <td>josepe</td>
                                <td>José Eduardo Peñaloza García</td>
                                <td>Responsable de departamento</td>
                                <td>DACEA</td>
                            </tr>
                            <tr role="button">
                                <td>josees</td>
                                <td>José Miguel Estrada Ramirez</td>
                                <td>Auxiliar</td>
                                <td>DATIC</td>
                            </tr>
                            <tr role="button">
                                <td>estebanmi</td>
                                <td>Esteban Miranda Gonzales</td>
                                <td>Responsable de departamento</td>
                                <td>DAMI</td>
                            </tr>
                            <tr role="button">
                                <td>mariaoc</td>
                                <td>María Ocampo Arellano</td>
                                <td>Auxiliar</td>
                                <td>DATIC</td>
                            </tr>
                            <tr role="button">
                                <td>silviama</td>
                                <td>Silvia Manzanares Demetrio</td>
                                <td>CDS</td>
                                <td>Responsable de departamento</td>
                            </tr>
                            <tr role="button">
                                <td>nathyes</td>
                                <td>Nathaly Escalona Ruiz</td>
                                <td>Responsable de departamento</td>
                                <td>DATIC</td>
                            </tr>
                            <tr role="button">
                                <td>pabloca</td>
                                <td>Pablo Castrejón Flores</td>
                                <td>Auxiliar</td>
                                <td>DATIC</td>
                            </tr>
                            <tr role="button">
                                <td>carlosdi</td>
                                <td>Carlos Díaz Parencia</td>
                                <td>Responsable de departamento</td>
                                <td>Servicios Escolares</td>
                            </tr>
                            <tr role="button">
                                <td>omarmo</td>
                                <td>Omar Morales Demetrio</td>
                                <td>Auxiliar</td>
                                <td>DATIC</td>
                            </tr>
                            <tr role="button">
                                <td>ricardocg</td>
                                <td>Ricardo Cárdenas Guevara</td>
                                <td>Auxiliar</td>
                                <td>DATIC</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <a href="/views/admin/user_register.html">
        <button type="button" class="btn btn-verde btn-floating shadow" data-bs-toggle="tooltip" data-bs-placement="left" title="Nuevo usuario">
            <svg class="feather-28">
                <use xlink:href="/assets/icons/feather-sprite.svg#user-plus" />
            </svg>
        </button>
    </a>
    <div class="modal fade" tabindex="-1" id="pendingRecordModal">
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
                                <p id="modal1RecordId"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de canalización:
                                </span>
                                <p id="modal1ChannellingDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de asignación:
                                </span>
                                <p id="modal1AssignmentDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Departamento:
                                </span>
                                <p id="modal1Department"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Prioridad:
                                </span>
                                <p>
                                    <span id="modal1Priority"></span>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <h5>Acciones:</h5>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <form action="/SISO_war/ServletRecords" method="POST" target="_blank" class="m-0">
                                    <input type="hidden" value="getRecordById" name="action">
                                    <input type="hidden" id="modal1RecordIdInput" name="recordIdInput">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="/assets/icons/feather-sprite.svg#file-text" />
                                        </svg>
                                        <span> Visualizar archivo</span>
                                    </button>
                                </form>
                            </div>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <button type="button" class="btn btn-primary w-100">
                                    <svg class="feather">
                                        <use xlink:href="/assets/icons/feather-sprite.svg#edit" />
                                    </svg>
                                    <span> Atender oficio</span>
                                </button>
                            </div>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <button type="button" class="btn btn-primary w-100">
                                    <svg class="feather">
                                        <use xlink:href="/assets/icons/feather-sprite.svg#edit" />
                                    </svg>
                                    <span> Atender oficio</span>
                                </button>
                            </div>
                        </div>
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
    <script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>

</html>