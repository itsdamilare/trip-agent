<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Bookings;
use App\Models\Packages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TravelController extends Controller
{

    public function getPackages()
    {
        $packages = Packages::get();

        return response($packages, 200);
    }

    public function getPackage(REQUEST $request, $id)
    {
        $packages = Packages::where(["id" => $id])->first();
        return response($packages, 200);
    }

    public function getBookings()
    {

        // Get the user making the request
        $user = Auth::guard('sanctum')->user();

        // Retrieve the bookings for the user
        $bookings = Bookings::where('user_id', $user->id)->get();

        return response($bookings, 200);
    }

    public function getSpecificBooking(REQUEST $request, $id)
    {
        // Get the user making the request
        $user = Auth::guard('sanctum')->user();

        // Retrieve the bookings for the user
        $bookings = Bookings::where(['user_id' => $user->id, "id" => $id])->get();

        return response($bookings, 200);
    }

    public function createBooking(Request $request)
    {

        // Validate the request data
        $validatedData = $request->validate([
            'package_id' => 'required',
            'booked_seats' => 'required|integer|min:1',
            'price' => 'required|numeric|min:0',
            'phone_number' => 'required',
            'email_address' => 'required|email',
            'name' => 'required',
        ]);

        // Get the authenticated user
        $user = Auth::guard('sanctum')->user();
// Check if the user is authenticated
        if ($user) {
            // Create a new booking using the validated data

            $booking = new Bookings();

            $booking['package_id'] = $validatedData['package_id'];
            $booking['booked_seats'] = $validatedData['booked_seats'];
            $booking['price'] = $validatedData['price'];
            $booking['phone_number'] = $validatedData['phone_number'];
            $booking['email_address'] = $validatedData['email_address'];
            $booking['name'] = $validatedData['name'];
            $booking['user_id'] = $user->id;

            // Save the booking to the database
            $booking->save();
        }

        // Return a response indicating success
        return response()->json([
            'success' => true,
            'message' => 'Booking created successfully!',
            'booking' => $booking,
        ], 200);

    }

    public function editBooking(Request $request, $id)
    {
        $booking = Bookings::find($id);

        if (!$booking) {
            return response()->json(['message' => 'Booking not found.'], 404);
        }

        // Check if the authenticated user is the owner of the booking
        if (Auth::guard('sanctum')->user()->id !== $booking->user_id) {
            return response()->json(['message' => 'Unauthorized.'], 401);
        }

        // Update the booking with the new data from the request
        $booking->package_id = $request->input('package_id');
        $booking->booked_seats = $request->input('booked_seats');
        $booking->price = $request->input('price');
        $booking->phone_number = $request->input('phone_number');
        $booking->email_address = $request->input('email_address');
        $booking->name = $request->input('name');
        $booking->save();

        return response()->json(['message' => 'Booking updated successfully.', 'data' => $booking]);
    }

    public function deleteBooking(Request $request, $bookingId)
    {
        // Retrieve the booking to delete
        $booking = Bookings::find($bookingId);

        // Check if the booking exists
        if (!$booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }

        // Check if the authenticated user is authorized to delete the booking
        if ($booking->user_id !== Auth::guard('sanctum')->user()->id) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // Delete the booking
        $booking->delete();

        // Return a success response
        return response()->json(['message' => 'Booking deleted successfully'], 200);
    }
}
