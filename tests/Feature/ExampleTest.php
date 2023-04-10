<?php

namespace Tests\Feature;

// use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Models\User;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */

    public function testUnauthenticatedUserCannotAccessProtectedRoutes()
    {
        $response = $this->get('/api/bookings');

        $response->assertStatus(401);
    }

    public function testAuthenticatedUserCanAccessProtectedRoutes()
    {
        $user = User::factory()->create();
        $token = $user->createToken('test-token')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->get('/api/bookings');

        $response->assertStatus(200);
    }

    public function testUserCanRegister()
    {
        $user = User::factory()->make();
        $data = [
            'name' => $user->name,
            'email' => $user->email,
            'password' => 'password',
            'password_confirmation' => 'password',
        ];

        $response = $this->post('/api/register', $data);
        $response->assertStatus(302);

        $this->assertDatabaseHas('users', [
            'name' => $user->name,
            'email' => $user->email,
        ]);
    }
    public function testUserCanLogin()
    {
        $user = User::factory()->create([
            'password' => bcrypt('password'),
        ]);
        $data = [
            'email' => $user->email,
            'password' => 'password',
        ];

        $response = $this->post('/api/login', $data);
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'token',
        ]);
    }

    public function testLogout()
    {
        $user = User::factory()->create();

        Sanctum::actingAs($user, ['*']);

        $response = $this->post('/api/logout');

        $response->assertStatus(200);

        $this->assertCount(0, $user->tokens);
    }
}
