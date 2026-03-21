<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\GeminiService;
use Illuminate\Support\Facades\Auth;

class ChatController extends Controller
{
    protected $geminiService;

    public function __construct(GeminiService $geminiService)
    {
        $this->geminiService = $geminiService;
    }

    public function sendMessage(Request $request)
    {
        $request->validate([
            'message' => 'required|string|max:1000',
            'context' => 'nullable|array'
        ]);

        $message = $request->input('message');
        $context = $request->input('context');
        $user = Auth::user();

        // Get the simulated AI response
        $response = $this->geminiService->generateChatResponse($message, $user, $context);

        return response()->json([
            'status' => 'success',
            'message' => $response,
            'is_ai' => true
        ]);
    }
}
