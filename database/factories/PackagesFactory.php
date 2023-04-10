<?php

namespace Database\Factories;

use App\Models\Packages;
use Illuminate\Database\Eloquent\Factories\Factory;

class PackagesFactory extends Factory
{
    protected $model = Packages::class;

    public function definition()
    {
        return [
            'title' => $this->faker->sentence(3),
            'description' => $this->faker->sentence(1),
            'price' => $this->faker->numberBetween(50, 500),
            'date' => $this->faker->dateTimeBetween('now', '2029-04-10')->format('Y-m-d'),
            'image_url' => $this->faker->imageUrl(640, 480, 'travel'),
            'is_available' => $this->faker->numberBetween(0, 1),
            'has_insurance' => $this->faker->numberBetween(0, 1),
            'total_seats' => $this->faker->numberBetween(5, 500),
            'booked_seats' => $this->faker->numberBetween(0, 5),
        ];
    }
}
