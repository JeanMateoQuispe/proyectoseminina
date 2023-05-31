<?php

require_once 'conexion.php';

class Curso extends Conexion{

  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function listarCursos(){
    try{
      $consulta = $this->conexion->prepare("SELECT * FROM cursos");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_NUM);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function listarCurs(){
    try{
      //Preparamos la consulta
      $consulta = $this->conexion->prepare("CALL spu_listar_cursos()");
      //Ejecutamos la consulta
      $consulta->execute();
      //Presentaremos los datos obtenidos como ARRAY asociativo
      $tabla = $consulta->fetchAll(PDO::FETCH_ASSOC);
      //Retornamos los datos obtenidos
      return $tabla;
    }catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function registrarCurso($datos = []){
    $respuesta = [
      "status"  => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registrar_cursos(?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["nombrecurso"],
          $datos["creditos"]
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: ". $e->getCode();
    }
    return $respuesta;
  }
  
  public function obtenerCurso($idcurso = 0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_obtener_cursos(?)");
      $consulta->execute(array($idcurso));
      return $consulta->fetch(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function actualizarCurso($datos = []){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_actualizar_cursos(?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["idcurso"],
          $datos["nombrecurso"],
          $datos["creditos"]
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

  public function eliminarCurso($idcurso = 0){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_eliminar_cursos(?)");
      $respuesta ["status"] = $consulta->execute(array($idcurso));
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

}