// Fill out your copyright notice in the Description page of Project Settings.

#include "MyActor.h"
#include "IWebSocket.h"       // Socket definition
#include "WebSocketsModule.h"
#include "Components/StaticMeshComponent.h"

// Sets default values
AMyActor::AMyActor()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.

	PrimaryActorTick.bCanEverTick = false;
	SomeText = "$)_#($_)@#$";

	VisualMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
	VisualMesh->SetupAttachment(RootComponent);

	static ConstructorHelpers::FObjectFinder<UStaticMesh> CubeVisualAsset(TEXT("/Game/Mesh/tree.tree"));

	if (CubeVisualAsset.Succeeded())
	{
		VisualMesh->SetStaticMesh(CubeVisualAsset.Object);
		VisualMesh->SetRelativeLocation(FVector(0.0f, 0.0f, 0.0f));
	}

}

void AMyActor::MyFunction1(FString SomeString)
{
	//UE_LOG(LogTemp, Log, TEXT("123123 %s"), *SomeString);

}

// Called when the game starts or when spawned
void AMyActor::BeginPlay()
{
	Super::BeginPlay();

	const FString ServerURL = TEXT("wss://noeight.net/ws/chat/lobby/"); // Your server URL. You can use ws, wss or wss+insecure.
	const FString ServerProtocol = TEXT("wss");              // The WebServer protocol you want to use.

	TSharedPtr<IWebSocket> Socket = FWebSocketsModule::Get().CreateWebSocket(ServerURL, ServerProtocol);

	// We bind all available events
	Socket->OnConnected().AddLambda([]() -> void {
		// This code will run once connected.
		});

	Socket->OnConnectionError().AddLambda([](const FString& Error) -> void {
		// This code will run if the connection failed. Check Error to see what happened.
		});

	Socket->OnClosed().AddLambda([](int32 StatusCode, const FString& Reason, bool bWasClean) -> void {
		// This code will run when the connection to the server has been terminated.
		// Because of an error or a call to Socket->Close().
		});

	Socket->OnMessage().AddLambda([](const FString& Message) -> void {
		// This code will run when we receive a string message from the server.

		if (GEngine)
			GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Orange, Message);
		});

	[]() {if (GEngine) GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Orange, "dd"); };

	Socket->OnRawMessage().AddLambda([](const void* Data, SIZE_T Size, SIZE_T BytesRemaining) -> void {
		// This code will run when we receive a raw (binary) message from the server.
		if (GEngine)
			GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Yellow, TEXT("we receive a raw (binary) message!"));

		});

	Socket->OnMessageSent().AddLambda([](const FString& MessageString) -> void {
		// This code is called after we sent a message to the server.
		});

	// And we finally connect to the server. 
	Socket->Connect();

	if (!Socket->IsConnected())
	{
		// Don't send if we're not connected.
		return;
	}

	const FString StringMessage = TEXT("Hello there !");
	// const TArray BinaryMessage = { 'H', 'e', 'l', 'l', 'o', ' ', 't', 'h', 'e', 'r', 'e', ' ', '!' };

	Socket->Send(StringMessage);
	// Socket->Send(BinaryMessage.GetData(), sizeof(uint8) * BinaryMessage.Num());

}

// Called every frame
void AMyActor::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

	FVector NewLocation = GetActorLocation();
	FRotator NewRotation = GetActorRotation();
	float RunningTime = GetGameTimeSinceCreation();
	float DeltaHeight = (FMath::Sin(RunningTime + DeltaTime) - FMath::Sin(RunningTime));
	NewLocation.Z += DeltaHeight * FloatSpeed;       //Scale our height by a factor of 20
	float DeltaRotation = DeltaTime * RotationSpeed;    //Rotate by 20 degrees per second
	NewRotation.Yaw += DeltaRotation;
	SetActorLocationAndRotation(NewLocation, NewRotation);


}

