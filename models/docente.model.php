<?php

require_once 'conexion.php';

class Docente extends Conexion{

  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function listarDocentes(){
    try{
      $consulta = $this->conexion->prepare("SELECT * FROM docentes");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_NUM);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function listarDocen(){
    try{
      //Preparamos la consulta
      $consulta = $this->conexion->prepare("CALL spu_listar_docentes()");
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

  public function registrarDocente($datos = []){
    $respuesta = [
      "status"  => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registrar_docente(?,?,?,?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["docente"],
          $datos["fechanac"],
          $datos["numdoc"],
          $datos["especialidad"],
          $datos["idcurso"],
          $datos["idcarrera"]
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: ". $e->getCode();
    }
    return $respuesta;
  }
  
  public function obtenerdocente($iddocente = 0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_obtener_docentes(?)");
      $consulta->execute(array($iddocente));
      return $consulta->fetch(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function actualizardocente ($datos = []){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_actualizar_docentes(?,?,?,?,?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["iddocente"],
          $datos["docente"],
          $datos["fechanac"],
          $datos["numdoc"],
          $datos["especialidad"],
          $datos["idcurso"],
          $datos["idcarrera"]
        )
      );
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }

  public function eliminardocente($iddocente = 0){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_eliminar_docentes(?)");
      $respuesta ["status"] = $consulta->execute(array($iddocente));
    }
    catch(Exception $e){
      $respuesta["message"] = "No se ha podido completar el proceso. Código error: " . $e->getCode();
    }
    return $respuesta;
  }
}