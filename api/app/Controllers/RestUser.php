<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;

class RestUser extends ResourceController
{
    protected $modelName = 'App\Models\UserModel';
    protected $format    = 'json';
    
    public function index() {
      return $this->respond(array(
        "data" => $this->model->findAll() ? $this->model->findAll() : [],
        "code" => 200
      ));
    }

    public function create() {
      $user = new UserModel();
      $json = $this->request->getJSON();

      if ($this->validate('user')) {
        $result = $user->insert([
          'name' => $json->{'name'},
          'document' => $json->{'document'},
          'email' => $json->{'email'},
          'phone' => $json->{'phone'},
        ]);
        if ($result) {
          return $this->respond(array( 
            "data" => $this->model->find($result),
            "message" => "Cliente guardado con exito!",
            "code" => 200
          ));
        } else {
          return $this->respond(array(
            "message" => "Por favor validar los datos Ingresados!",
            "code" => 500
          ));
        }
      }

      return $this->respond(array(
        "message" => "Por favor validar los datos Ingresados!",
        "code" => 500
      ));
    }

    public function update($id = null) {
      $user = new UserModel();
      $json = $this->request->getJSON();

      if ($this->validate('user')) {
        $result = $user->update($id, [
          'name' => $json->{'name'},
          'document' => $json->{'document'},
          'email' => $json->{'email'},
          'phone' => $json->{'phone'},
        ]);
        if ($result) {
          return $this->respond(array( 
            "data" => $this->model->find($result),
            "message" => "Cliente Actualizado con exito!",
            "code" => 200
          ));
        } else {
          return $this->respond(array(
            "message" => "Por favor validar los datos Ingresados!",
            "code" => 500
          ));
        }
      }

      return $this->respond(array(
        "message" => "Por favor validar los datos Ingresados!",
        "code" => 500
      ));
    }

    public function delete($id = null) {
      $user = new UserModel();

      $result = $user->delete($id);

      if ($result) {
        return $this->respond(array( 
          "message" => "Cliente Eliminado con exito!",
          "code" => 200
        ));
      } else {
        return $this->respond(array(
          "message" => "Ha ocurrido un error en el servidor!",
          "code" => 500
        ));
      }
    }

}