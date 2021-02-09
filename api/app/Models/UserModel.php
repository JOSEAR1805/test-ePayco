<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model {
    protected $table      = 'users';
    protected $primaryKey = 'id';

    protected $useAutoIncrement = true;

    protected $returnType     = 'array';
    protected $useSoftDeletes = true;

    protected $allowedFields = ['name', 'document', 'email', 'phone'];

    protected $useTimestamps = true;
    protected $createdField  = 'createdAt';
    protected $updatedField  = 'updatedAt';
    protected $deletedField  = 'deletedAt';

    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;
}