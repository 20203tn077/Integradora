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

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<c:if test="${access}">
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
                    <a class="nav-link active" href="${context}/Gestión_de_Oficios?redirect=records">Gestión de oficios</a>
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

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

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

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <div class="container mt-4">
        <div class="card shadow-sm">
            <h5 class="card-header">Gestión de oficios</h5>
            <div class="card-body" height="100px">
                <h5>Sin atender:</h5>
                <div class="table-container">
                    <table class="table table-azul table-striped table-hover border text-center">
                        <thead class="thead-azul display-none">
                            <tr>
                                <th>No. de Oficio</th>
                                <th>Departamento</th>
                                <th>Fecha de canalización</th>
                                <th>Prioridad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recordList1}" var="record">
                                <tr role="button"
                                onclick="showModalDetails('${record.id_minutes}')">
                                <td>${record.id_minutes}</td>
                                <td>
                                    ${record.departmentId.nameDepartment}
                                </td>
                                <td>
                                    ${record.dateChannelling}
                                </td>
                                <td>
                                    <c:if test="${record.priorityId.idPriority == 1}">
                                        <span class="badge bg-danger w-100">${record.priorityId.namePriority}</span>
                                    </c:if>
                                    <c:if test="${record.priorityId.idPriority == 2}">
                                        <span class="badge bg-naranja w-100">${record.priorityId.namePriority}</span>
                                    </c:if>
                                    <c:if test="${record.priorityId.idPriority == 3}">
                                        <span class="badge bg-warning w-100 text-dark">${record.priorityId.namePriority}</span>
                                    </c:if>
                                    <c:if test="${record.priorityId.idPriority == 4}">
                                        <span class="badge bg-success w-100">${record.priorityId.namePriority}</span>
                                    </c:if>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <h5 class="mt-3">Atendidos:</h5>
                <div class="table-container">
                    <table class="table table-azul table-striped table-hover border text-center">
                        <thead class="thead-azul display-none">
                            <tr>
                                <th>No. de Oficio</th>
                                <th>Fecha de canalización</th>
                                <th>Fecha de respuesta</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recordList2}" var="record">
                                <tr role="button"
                                onclick="showModalDetails('${record.id_minutes}')">
                                <td>${record.id_minutes}</td>
                                <td>
                                    ${record.dateChannelling}
                                </td>
                                <td>
                                    ${record.dateResponse}
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<a href="${context}/Nuevo_Oficio?redirect=recordRegister">
    <button type="button" class="btn btn-verde btn-floating shadow" data-bs-toggle="tooltip" data-bs-placement="left" title="Nuevo oficio">
        <svg class="feather-28">
            <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-plus" />
        </svg>
    </button>
</a>
    
    
<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<div class="modal fade" tabindex="-1" id="modalDetails">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Auxiliar</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <span class="fw-bold">
                            Número de oficio:
                        </span>
                        <p id="modalDetails_id"></p>
                    </div>
                    <div class="col-md-6">
                        <span class="fw-bold">
                            Fecha de canalización:
                        </span>
                        <p id="modalDetails_channelling"></p>
                    </div>
                    <div class="col-md-6" id="modalDetails_assignmentContainer">
                        <span class="fw-bold">
                            Fecha de asignación:
                        </span>
                        <p id="modalDetails_assignment"></p>
                    </div>
                    <div class="col-md-6" id="modalDetails_responseContainer">
                        <span class="fw-bold">
                            Fecha de respuesta:
                        </span>
                        <p id="modalDetails_response"></p>
                    </div>
                    <div class="col-md-6">
                        <span class="fw-bold">
                            Prioridad:
                        </span>
                        <p id="modalDetails_priority"></p>
                    </div>
                    <div class="col-md-6">
                        <span class="fw-bold">
                            Departamento:
                        </span>
                        <p id="modalDetails_department"></p>
                    </div>
                    <div class="col-md-6" id="modalDetails_commentContainer">
                        <span class="fw-bold">
                            Comentario:
                        </span>
                        <p id="modalDetails_comment"></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100">
                    <div class="p-1 col-md-6 col-lg-4">
                        <form action="${context}/Visualizar_Oficio" method="post" class="d-inline" target="_blank">
                            <input type="hidden" name="action" value="viewRecordFile">
                            <input type="hidden" name="id" id="modalDetails_viewForm">
                            <button type="submit" class="btn btn-primary w-100">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
                                </svg>
                                <span> Visualizar oficio</span>
                            </button>
                        </form>
                    </div>
                    <div class="p-1 col-md-6 col-lg-4" id="modalDetails_rechannelButtonContainer">
                        <a href="#" class="btn btn-verde w-100">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                            </svg>
                            <span> Recanalizar oficio</span>
                        </a>
                    </div>
                    <div class="p-1 col-md-6 col-lg-4" data-bs-target="#modalDelete" data-bs-toggle="modal"
                        data-bs-dismiss="modal" id="modalDetails_deleteButtonContainer">
                        <button type="button" class="btn btn-danger w-100">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#trash-2" />
                            </svg>
                            <span> Eliminar oficio</span>
                        </button>
                    </div>
                    <div class="p-1 col-md-6 col-lg-4" data-bs-target="#modalDelete" data-bs-toggle="modal"
                        data-bs-dismiss="modal" id="modalDetails_responseButtonContainer">
                        <button type="button" class="btn btn-verde w-100">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#folder" />
                            </svg>
                            <span> Archivos de respuesta</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<div class="modal fade" tabindex="-1" id="modalDelete">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Eliminar oficio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col">
                        <p>¿Desea eliminar el oficio <span id="modalDelete_id"></span>?</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100">
                    <div class="p-1 col-md-6 col-lg-4">
                        <button class="btn btn-secondary w-100" data-bs-target="#modalDetails"
                            data-bs-toggle="modal" data-bs-dismiss="modal">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                            </svg>
                            <span> Cancelar</span>
                        </button>
                    </div>
                    <div class="p-1 col-md-6 col-lg-4">
                        <form action="${context}/Gestión_de_Usuarios" method="post" class="d-inline">
                            <input type="hidden" name="action" value="deleteUser">
                            <input type="hidden" name="id" id="modalDelete_formId">
                            <button type="submit" class="btn btn-danger w-100">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#trash-2" />
                                </svg>
                                <span> Eliminar</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<c:if test="${! access}">
  <div class="alert alert-danger m-3">
    <svg class="feather-24">
      <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
    </svg>
    <span> Error: No tienes acceso a este sitio.</span>
  </div>
</c:if>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

<input type="hidden" id="context" value="${context}">
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script src="${context}/assets/js/oficialia/recordListUtil.js"></script>
</body>

</html>