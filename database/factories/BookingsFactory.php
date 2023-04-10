<?php

namespace Database\Factories;

use App\Models\Bookings;
use Illuminate\Database\Eloquent\Factories\Factory;

class BookingsFactory extends Factory
{
    protected $model = Bookings::class;

    public function definition()
    {
        return [
            'user_id' => $this->faker->numberBetween(0, 1),
            'package_id' => $this->faker->numberBetween(0, 1),
            'price' => $this->faker->numberBetween(50, 500),
            'booked_seats' => $this->faker->numberBetween(0, 5),
            'name' => $this->faker->sentence(2),
            'phone_number' => $this->faker->phoneNumber,
            'email_address' => $this->faker->email,
        ];
    }
}
