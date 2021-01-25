// Fill out your copyright notice in the Description page of Project Settings.

    // Socket definition
#include "MyGameInstance.h"
#include "WebSocketsModule.h"

void UMyGameInstance::Init()
{
    Super::Init();
    // Load the WebSockets module. An assertion will fail if it isn't found.
    FWebSocketsModule& Module = FModuleManager::LoadModuleChecked<FWebSocketsModule>(TEXT("WebSockets"));
}