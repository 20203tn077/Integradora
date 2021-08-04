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
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <nav class="navbar-nav">
                        <a class="nav-link active" href="${context}/Gestión_de_Oficios?redirect=records">Gestión de oficios</a>
                        <a class="nav-link" href="${context}/Gestión_de_Auxiliares?redirect=assistants">Gestión de auxiliares</a>
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
                <h5 class="card-header">Gestión de oficios</h5>
                <div class="card-body" height="100px">
                    <h5>Pendientes:</h5>
                    <div class="table-container">
                        <table class="table table-azul table-striped table-hover border text-center">
                            <thead class="thead-azul display-none">
                                <tr>
                                    <th>No. de Oficio</th>
                                    <th>Fecha de asignación</th>
                                    <th>Prioridad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr role="button"
                                    onclick="showModal1('1', '2021-07-26 04:47:00.0', '', 'DAMI', 'Muy importante')">
                                    <td>1</td>
                                    <td>
                                        Sin asignacion
                                    </td>
                                    <td>
                                        <span class="badge bg-naranja w-100">Muy importante</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('3', '2021-07-26 04:47:17.0', '2021-06-07 16:45:25.0', 'DAMI', 'Importante')">
                                    <td>3</td>
                                    <td>
                                        2021-06-07 16:45:25.0
                                    </td>
                                    <td>
                                        <span class="badge bg-warning text-dark w-100">Importante</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('5', '2021-07-26 04:47:39.0', '2021-06-10 12:46:07.0', 'DAMI', 'Urgente')">
                                    <td>5</td>
                                    <td>
                                        2021-06-10 12:46:07.0
                                    </td>
                                    <td>
                                        <span class="badge bg-danger w-100">Urgente</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('7', '2021-07-26 04:47:45.0', '2021-06-11 17:58:08.0', 'DAMI', 'Muy importante')">
                                    <td>7</td>
                                    <td>
                                        2021-06-11 17:58:08.0
                                    </td>
                                    <td>
                                        <span class="badge bg-naranja w-100">Muy importante</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('6', '2021-07-26 04:47:43.0', '2021-06-11 19:18:29.0', 'DAMI', 'Normal')">
                                    <td>6</td>
                                    <td>
                                        2021-06-11 19:18:29.0
                                    </td>
                                    <td>
                                        <span class="badge bg-success w-100">Normal</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('8', '2021-07-26 04:47:48.0', '2021-06-12 14:05:29.0', 'DATIC', 'Normal')">
                                    <td>8</td>
                                    <td>
                                        2021-06-12 14:05:29.0
                                    </td>
                                    <td>
                                        <span class="badge bg-success w-100">Normal</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('9', '2021-07-26 04:47:51.0', '2021-06-14 10:07:53.0', 'DAMI', 'Importante')">
                                    <td>9</td>
                                    <td>
                                        2021-06-14 10:07:53.0
                                    </td>
                                    <td>
                                        <span class="badge bg-warning text-dark w-100">Importante</span>
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal1('10', '2021-07-26 04:47:54.0', '2021-07-18 11:59:49.0', 'DAMI', 'Muy importante')">
                                    <td>10</td>
                                    <td>
                                        2021-07-18 11:59:49.0
                                    </td>
                                    <td>
                                        <span class="badge bg-naranja w-100">Muy importante</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <h5 class="mt-3">Atendidos:</h5>
                    <div class="table-container">
                        <table class="table table-azul table-striped table-hover border text-center">
                            <thead class="thead-azul display-none">
                                <tr>
                                    <th>No. de Oficio</th>
                                    <th>Fecha de asignación</th>
                                    <th>Fecha de respuesta</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr role="button"
                                    onclick="showModal2('4', '2021-07-26 04:47:21.0', '2021-06-08 14:10:46.0', '2021-06-12 18:10:46.0' , 'DATIC', 'Urgente', 'Revisión Completa')">
                                    <td>4</td>
                                    <td>
                                        2021-06-08 14:10:46.0
                                    </td>
                                    <td>
                                        2021-06-12 18:10:46.0
                                    </td>
                                </tr>
                                <tr role="button"
                                    onclick="showModal2('2', '2021-07-26 04:47:09.0', '2021-06-06 16:10:30.0', '2021-06-15 17:10:15.0' , 'DATIC', 'Urgente', 'Archivo revisado')">
                                    <td>2</td>
                                    <td>
                                        2021-06-06 16:10:30.0
                                    </td>
                                    <td>
                                        2021-06-15 17:10:15.0
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
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
                                    <form action="${context}/ServletRecords" method="POST" target="_blank" class="m-0">
                                        <input type="hidden" value="getRecordById" name="action">
                                        <input type="hidden" id="modal1RecordIdInput" name="recordIdInput">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <svg class="feather">
                                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
                                            </svg>
                                            <span> Visualizar archivo</span>
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-3">
                                    <button type="button" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                                        </svg>
                                        <span> Atender oficio</span>
                                    </button>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-3">
                                    <button type="button" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
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
                                    <form action="${context}/ServletRecords" method="POST" target="_blank" class="m-0">
                                        <input type="hidden" value="getRecordById" name="action">
                                        <input type="hidden" id="modal2RecordIdInput" name="recordIdInput">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <svg class="feather">
                                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
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