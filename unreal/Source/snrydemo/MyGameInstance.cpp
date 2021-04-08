// Fill out your copyright notice in the Description page of Project Settings.

    // Socket definition
#include "MyGameInstance.h"
#include "WebSocketsModule.h"

const FString ServerURL = TEXT("ws://noeight.net:4000/socket/websocket?token=undefined&vsn=2.0.0"); // Your server URL. You can use ws, wss or wss+insecure.
const FString ServerProtocol = TEXT("ws");              // The WebServer protocol you want to use.


// And we finally connect to the server. 


void UMyGameInstance::Init()
{
    Super::Init();
    // Load the WebSockets module. An assertion will fail if it isn't found.
    FWebSocketsModule& Module = FModuleManager::LoadModuleChecked<FWebSocketsModule>(TEXT("WebSockets"));
   
}