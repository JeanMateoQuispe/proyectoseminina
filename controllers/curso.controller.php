<?php

require_once '../models/curso.model.php';

if (isset($_POST['operacion'])){

  $curso = new Curso();

  if ($_POST['operacion'] == 'listar'){
    $datos = $curso->listarCursos();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'listarcursos'){
    //Ejecutamos el metodo y guardamos el resultado
    $datos = $curso->listarCurs();

    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion'] == 'registrarcurso'){
    $datosGuardar = [
      "nombrecurso"      => $_POST['nombrecurso'],
      "creditos"         => $_POST['creditos']
    ];

    $respuesta = $curso->registrarCurso($datosGuardar);
    echo json_encode($respuesta );
  }

  if($_POST['operacion'] == 'obtenercurso'){
    $respuesta = $curso->obtenerCurso($_POST['idcurso']);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'actualizarcurso'){
    $datosActualizar = [
      "idcurso"            => $_POST['idcurso'],
      "nombrecurso"        => $_POST['nombrecurso'],
      "creditos"           => $_POST['creditos']
    ];

    $respuesta = $curso->actualizarCurso($datosActualizar);
    echo json_encode($respuesta);
  }

  if($_POST['operacion'] == 'eliminarcurso'){
    $respuesta = $curso->eliminarCurso($_POST['idcurso']);
    echo json_encode($respuesta);
  }
}
