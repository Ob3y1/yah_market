<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // public function loginAsAdmin(Request $request)
    // {
    //     // تحقق من صحة البيانات المدخلة
    //     $request->validate([
    //         'email' => 'required|email',
    //         'password' => 'required|string|min:6',
    //     ]);

    //     // محاولة جلب المستخدم بناءً على البريد الإلكتروني
    //     $user = User::where('email', $request->input('email'))->first();

    //     // التحقق من وجود المستخدم وكلمة المرور الصحيحة
    //     if ($user && Hash::check($request->input('password'), $user->password)) {
    //         // التحقق من أن المستخدم هو مسؤول (admin)
    //         if ($user->role !== 'admin') {
    //             return response()->json(['message' => 'You are not authorized to access this area.'], 403);
    //         }

    //         // توليد Access Token للمسؤول باستخدام Passport
    //         $token = $user->createToken('AdminToken')->accessToken;

    //         return response()->json([
    //             'message' => 'Login successful as Admin.',
    //             'token' => $token,
    //             'user' => $user
    //         ], 200);
    //     }

    //     return response()->json(['message' => 'Invalid credentials'], 401);
    // }
    // تسجيل الدخول
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:4',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            if ($user->role !== 'user') {
                return response()->json(['message' => 'You are not authorized to access this area.'], 403);
            }
            $token = $user->createToken('user')->accessToken;
            return response()->json(['token' => $token], 200);
        }

        return response()->json(['error' => 'Unauthorized'], 401);
    }

    // تسجيل حساب جديد
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:4',
            'gender' => 'required',
            'birth_date' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }


        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'gender' => $request->gender,
            'birth_date' => $request->birth_date
        ]);

        $token = $user->createToken('user')->accessToken;


        return response()->json(['token' => $token], 201);
    }

    // تسجيل الخروج
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        return response()->json(['message' => 'Successfully logged out']);
    }

    // عرض معلومات المستخدم
    public function user(Request $request)
    {
        return response()->json($request->user());
    }

    // تعديل معلومات المستخدم
    public function update(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|required|string|max:255',
             'email' => 'sometimes|required|string|email|max:255|unique:users,email,' . $user->id,
            'password' => 'sometimes|required|string|min:4',
            'gender' => 'sometimes',
            'birth_date' => 'sometimes'
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        if ($request->has('name')) {
            $user->name = $request->name;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }

        if ($request->has('password')) {
            $user->password = Hash::make($request->password);
        }

        if ($request->has('gender')) {
            $user->gender = $request->gender;
        }

        if ($request->has('birth_date')) {
            $user->birth_date = $request->birth_date;
        }

        $user->save();

        return response()->json([$user], 201);
    }
}
