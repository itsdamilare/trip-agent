<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bookings extends Model
{
    use HasFactory;

    protected $fillable = [
        'package_id',
        'booked_seats',
        'price',
        'phone_number',
        'email_address',
        'name',
    ];
}
