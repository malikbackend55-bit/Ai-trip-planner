<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\AiService;
use Illuminate\Support\Facades\Auth;

class ChatController extends Controller
{
    protected $aiService;

    public function __construct(AiService $aiService)
    {
        $this->aiService = $aiService;
    }

    public function sendMessage(Request $request)
    {
        $request->validate([
            'message' => 'required|string|max:1000'
        ]);

        $message = $request->input('message');
        $user = Auth::user();

        // Get the simulated AI response
        $response = $this->aiService->generateChatResponse($message, $user);

        return response()->json([
            'status' => 'success',
            'message' => $response,
            'is_ai' => true
        ]);
    }
}
