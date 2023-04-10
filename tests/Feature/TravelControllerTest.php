<?php

use App\Models\Bookings;
use App\Models\Packages;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class TravelControllerTest extends TestCase
{
    use RefreshDatabase;

    public function testGetPackages()
    {
        $packages = Packages::factory()->count(5)->create();

        $user = User::factory()->create();
        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->get('/api/packages');

        $this->assertEquals(200, $response->status());

    }

    public function testGetSpecificPackage()
    {
        $package = Packages::factory()->create();
        $user = User::factory()->create();
        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->get('/api/packages/' . $package->id);

        $response->assertStatus(200)
            ->assertJson([
                'id' => $package->id,
            ]);
    }

    public function testCreateBooking()
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $package = Packages::factory()->create();
        $data = [
            'package_id' => $package->id,
            'booked_seats' => 2,
            'price' => 2000,
            'phone_number' => '08012345678',
            'email_address' => 'johndoe@example.com',
            'name' => 'John Doe',
        ];

        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->post('/api/bookings', $data);

        $response->assertStatus(200)
            ->assertJson([
                'success' => true,
                'message' => 'Booking created successfully!',
            ]);
    }

    public function testEditBooking()
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $booking = Bookings::factory()->create(['user_id' => $user->id]);

        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->put("/api/bookings/{$booking->id}", [
            'package_id' => $newPackageId = 2,
            'booked_seats' => $newBookedSeats = 3,
            'price' => $newPrice = 250.00,
            'phone_number' => $newPhoneNumber = '08012345678',
            'email_address' => $newEmailAddress = 'johndoe@example.com',
            'name' => $newName = 'John Doe',
        ]);

        $response->assertStatus(200);

        $response->assertJson([
            'data' => [
                'package_id' => $newPackageId,
                'booked_seats' => $newBookedSeats,
                'price' => $newPrice,
                'phone_number' => $newPhoneNumber,
                'email_address' => $newEmailAddress,
                'name' => $newName,
            ],
        ]);

        $booking->refresh();

        $this->assertEquals($newPackageId, $booking->package_id);
        $this->assertEquals($newBookedSeats, $booking->booked_seats);
        $this->assertEquals($newPrice, $booking->price);
        $this->assertEquals($newPhoneNumber, $booking->phone_number);
        $this->assertEquals($newEmailAddress, $booking->email_address);
        $this->assertEquals($newName, $booking->name);
    }

    public function testDeleteBooking()
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $booking = Bookings::factory()->create(['user_id' => $user->id]);

        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->delete('/api/bookings/' . $booking->id);

        $response->assertStatus(200)
            ->assertJson([
                'message' => 'Booking deleted successfully',
            ]);
    }

    public function testGetSpecificBooking()
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $booking = Bookings::factory()->create(['user_id' => $user->id]);
        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->get("/api/bookings/{$booking->id}");

        $response->assertStatus(200);

        $response->assertJson([[
            'id' => $booking->id,
            'package_id' => $booking->package_id,
            'booked_seats' => $booking->booked_seats,
            'price' => $booking->price,
            'phone_number' => $booking->phone_number,
            'email_address' => $booking->email_address,
            'name' => $booking->name,
            'user_id' => $booking->user_id,
        ]]);
    }

    public function testGetBookings()
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);
        $booking1 = Bookings::factory()->create(['user_id' => $user->id]);
        $booking2 = Bookings::factory()->create(['user_id' => $user->id]);

        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->get('/api/bookings');

        $response->assertStatus(200);

    }
}
