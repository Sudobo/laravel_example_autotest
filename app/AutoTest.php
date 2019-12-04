<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AutoTest extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'autotest';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['number_a', 'number_b'];
}