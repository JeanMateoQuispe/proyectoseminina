<?php

//Llamamos el modelo de matricula(logica)
require_once '../models/matricula.php';

//Si existe alguna operación en curso
if(isset($_POST['operacion'])){
  //Instancia de la clase Matricula
  $matricula = new Matricula();

  //Si la operación es listar
  if($_POST['operacion'] == 'listar'){
    //Ejecutamos el método y guardamos el resultado
    $datos = $matricula->Listar();
    
    if($datos){
      // echo json_encode($datos);
      foreach($datos as $registro){
        echo "
            <tr>
                <td>{$registro['idmatricula']}</td>
                <td>{$registro['nombres']}</td>
                <td>{$registro['carrera']}</td>
                <td>{$registro['periodo']}</td>
                <td>{$registro['semestre']}</td>
                <td>{$registro['turno']}</td>
                <td>{$registro['fechainicio']}</td>
                <td>{$registro['fechafinal']}</td>
                <td>{$registro['costo']}</td>
                <td >
                  <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-idmatricula='{$registro['idmatricula']}'>Eliminar</a> 
                  <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#modal-matricula' data-idmatricula ='{$registro['idmatricula']}'>Editar</a>
                </td>
            </tr>
        ";
      }
    }
  }

  if($_POST['operacion'] == 'registrar'){
    $datosGuardar = [
      "nombres"         => $_POST['nombres'],
      "numdoc"          => $_POST['numdoc'],
      "idcarrera"       => $_POST['idcarrera'],
      "periodo"         => $_POST['periodo'],
      "semestre"        => $_POST['semestre'],
      "turno"           => $_POST['turno'],
      "fechainicio"     => $_POST['fechainicio'],
      "fechafinal"      => $_POST['fechafinal']

    ];

    $respuesta = $matricula->registrar($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtener'){
    $respuesta = $matricula->obtener($_POST['idmatricula']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
      "idmatricula"       => $_POST['idmatricula'],
      "nombres"           => $_POST['nombres'],
      "numdoc"            => $_POST['numdoc'],
      "idcarrera"         => $_POST['idcarrera'],
      "periodo"           => $_POST['periodo'],
      "semestre"          => $_POST['semestre'],
      "turno"             => $_POST['turno'],
      "fechainicio"       => $_POST['fechainicio'],
      "fechafinal"        => $_POST['fechafinal']

    ];

    $respuesta = $matricula->actualizar($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminar'){
    $respuesta = $matricula->eliminar($_POST['idmatricula']);
    echo json_encode($respuesta);
  }


}