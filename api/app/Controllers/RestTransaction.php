<?php

namespace App\Controllers;

use App\Models\TransactionModel;
use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;

class RestTransaction extends ResourceController {
  protected $modelName = 'App\Models\TransactionModel';
  protected $format    = 'json';

  // CONSULTAR SALDO
  public function consultBalance() {
    $userModel = new UserModel();
    $json = $this->request->getJSON();

    if ($json->{'document'} && $json->{'phone'}) {
      $user = $userModel->where('document', $json->{'document'})->where('phone', $json->{'phone'})->first();
      if ($user) {
        $transaction = $this->model->where('userId', $user['id'])->find();
        return $this->respond(array( 
          "data" => $transaction,
          "user" => $user,
          "code" => 200
        ));
      } else {
        return $this->respond(array(
          "message" => "No existe Cliente con los parametros ingresados!",
          "code" => 500
        ));
      }
    } else {
      return $this->respond(array(
        "message" => "Por favor rellenar campos requeridos!",
        "code" => 500
      ));
    }
  }

  // RECARGAR SALDO
  public function rechargeBalance() {
    $transaction = new TransactionModel();
    $userModel = new UserModel();
    $json = $this->request->getJSON();

    if ($json->{'document'} && $json->{'phone'} && $json->{'quantity'}) {
      $user = $userModel->where('document', $json->{'document'})->where('phone', $json->{'phone'})->first();

      if ($user) {
        $result = $transaction->insert([
          'userId' => intVal($user['id']),
          'type' => 1,
          'status' => 1,
          'quantity' => $json->{'quantity'},
        ]);

        if ($result) {
          return $this->respond(array( 
            "message" => "Recarga realizada con exito!",
            "code" => 200
          ));
        } else {
          return $this->respond(array(
            "message" => "Ha ocurrido eun error en el servidor!",
            "code" => 500
          ));
        }

      } else {
        return $this->respond(array(
          "message" => "No existe Cliente con los parametros ingresados!",
          "code" => 500
        ));
      }

    } else {
      return $this->respond(array(
        "message" => "Por favor rellenar campos requeridos!",
        "code" => 500
      ));
    }
  }

}