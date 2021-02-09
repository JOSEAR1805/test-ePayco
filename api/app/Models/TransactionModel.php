<?php

namespace App\Models;

use CodeIgniter\Model;

class TransactionModel extends Model {
    protected $table      = 'transactions';
    protected $primaryKey = 'id';

    protected $useAutoIncrement = true;

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['userId', 'type', 'status', 'quantity'];

    protected $useTimestamps = true;
    protected $createdField  = 'createdAt';
    protected $updatedField  = 'updatedAt';
    // protected $deletedField  = 'deletedAt';

    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;


}