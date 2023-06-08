<?php

require_once '../models/curso.php';

if(isset($_POST['operacion'])){
    $curso = new Curso();

    if ($_POST['operacion'] == 'listar'){
        $datos = $curso->Listar();

        if($datos){
            echo json_encode($datos);
        }
    }

    if($_POST['operacion'] == 'listarcursos'){
        //Ejecutamos el metodo y guardamos el resultado
        $datos = $curso->ListarCursos();
    
        if($datos){
          echo json_encode($datos);
        }
      }


    // if($_POST['operacion'] == 'listarcurso'){
    // //Ejecutamos el método y guardamos el resultado
    // $datos = $curso->ListarCursos();
    //     if($datos){
    //         // echo json_encode($datos);
    //         foreach($datos as $registro){
    //             echo "
    //                 <tr>
    //                     <td>{$registro['iddtcarrs']}</td>
    //                     <td>{$registro['carrera']}</td>
    //                     <td>{$registro['duracion']}</td>
    //                     <td>{$registro['costo']}</td>
    //                     <td>{$registro['curso']}</td>
    //                     <td>{$registro['creditos']}</td>
    //                     <td >
    //                         <a href='#' class='eliminar btn btn-outline-danger btn-sm' data-idcurso='{$registro['idcurso']}'>Eliminar</a> 
    //                         <a href='#' class='editar btn btn-outline-info btn-sm' data-bs-toggle='modal' data-bs-target='#md-cursos' data-idcurso ='{$registro['idcurso']}'>Editar</a>
    //                     </td>
    //                 </tr>
    //             ";
    //         }
    //     }
    // }

    if($_POST['operacion'] == 'registrar'){
        $datosGuardar = [
          "curso"         => $_POST['curso'],
          "creditos"      => $_POST['creditos']
        ];
    
        $respuesta = $curso->registrar($datosGuardar);
        echo json_encode($respuesta );
      }

    if($_POST['operacion'] == 'obtenercur'){
        $respuesta = $curso->obtener($_POST['idcurso']);
        echo json_encode($respuesta);
    }
    
    if($_POST['operacion'] == 'actualizar'){
    $datosActualizar = [
        "idcurso"         => $_POST['idcurso'],
        "curso"           => $_POST['curso'], 
        "creditos"        => $_POST['creditos']
    ];

    $respuesta = $curso->actualizar($datosActualizar);
    echo json_encode($respuesta);
    }

    if($_POST['operacion'] == 'eliminar'){
        $respuesta = $curso->eliminar($_POST['idcurso']);
        echo json_encode($respuesta);
    }
}