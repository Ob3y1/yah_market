<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // التحقق من أن المستخدم هو Admin
        if (Auth::check() && Auth::user()->role === 'admin') {
            return $next($request);
        }

        return response()->json(['message' => 'Unauthorized. Admins only.'], 403);
    }
}
