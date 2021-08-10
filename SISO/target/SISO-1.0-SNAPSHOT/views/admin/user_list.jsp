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
                    <a class="nav-link active" href="${context}/Gestión_de_Usuarios?redirect=users">Gestión de usuarios</a>
                    <a class="nav-link" href="${context}/Gestión_de_Departamentos?redirect=departments">Gestión de departamentos</a>
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
                            <c:forEach items="${userList}" var="user">
                                <tr role="button" onclick="showModalDetails('${user.id_user}')">
                                    <td>${user.nameUser}</td>
                                    <td>${user.name.concat(" ").concat(user.lastname1).concat(" ").concat(user.lastname2)}</td>
                                    <td>${user.type_id.nameType}</td>
                                    <td>${user.department_id.nameDepartment}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <a href="/views/admin/user_register.html">
        <button type="button" class="btn btn-verde btn-floating shadow" data-bs-toggle="tooltip" data-bs-placement="left" title="Nuevo usuario">
            <svg class="feather-28">
                <use xlink:href="${context}/assets/icons/feather-sprite.svg#user-plus" />
            </svg>
        </button>
    </a>
    
<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <div class="modal fade" tabindex="-1" id="modalDetails">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <span class="fw-bold">
                                Nombre de usuario:
                            </span>
                            <p id="modalDetails_username"></p>
                        </div>
                        <div class="col-md-6">
                            <span class="fw-bold">
                                Nombre:
                            </span>
                            <p id="modalDetails_name"></p>
                        </div>
                        <div class="col-md-6">
                            <span class="fw-bold">
                                Correo electrónico:
                            </span>
                            <p id="modalDetails_email"></p>
                        </div>
                        <div class="col-md-6">
                            <span class="fw-bold">
                                Rol:
                            </span>
                            <p id="modalDetails_role"></p>
                        </div>
                        <div class="col-md-6" id="modalDetails_departmentContainer">
                            <span class="fw-bold">
                                Departamento:
                            </span>
                            <p id="modalDetails_department"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row w-100">
                        <div class="p-1 col-md-6 col-lg-4">
                            <a href="#" class="btn btn-verde w-100">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                                </svg>
                                <span> Modificar usuario</span>
                            </a>
                        </div>
                        <div class="p-1 col-md-6 col-lg-4" data-bs-target="#modalDelete" data-bs-toggle="modal"
                            data-bs-dismiss="modal">
                            <button type="button" class="btn btn-danger w-100" onclick="showModalDelete()">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#trash-2" />
                                </svg>
                                <span> Eliminar usuario</span>
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
                    <h5 class="modal-title">Eliminar auxiliar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col">
                            <p>¿Desea eliminar a <span id="modalDelete_name"></span>?</p>
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
    <script src="${context}/assets/js/admin/userListUtil.js"></script>
</body>

</html>