// Fill out your copyright notice in the Description page of Project Settings.

#include "MyActor.h"
#include "Components/StaticMeshComponent.h"
#include "Dom/JsonObject.h"
#include "ActionRPGLoadingScreen.h"




void AMyActor::PlayLoadingScreen(bool bPlayUntilStopped, float PlayTime)
{
	IActionRPGLoadingScreenModule& LoadingScreenModule = IActionRPGLoadingScreenModule::Get();
	LoadingScreenModule.StartInGameLoadingScreen(bPlayUntilStopped, PlayTime);
}

void AMyActor::StopLoadingScreen()
{
	IActionRPGLoadingScreenModule& LoadingScreenModule = IActionRPGLoadingScreenModule::Get();
	LoadingScreenModule.StopInGameLoadingScreen();
}

// Sets default values
AMyActor::AMyActor()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = false;

	TextMesh = CreateDefaultSubobject<UTextRenderComponent>(TEXT("TextMesh1"));
	TextMesh->SetupAttachment(RootComponent);

	TextMesh->SetRelativeLocation(FVector(0.0f, 0.0f, 0.0f));
	TextMesh->SetWorldScale3D(FVector(4.0f, 4.0f, 4.0f));

	CountdownText = CreateDefaultSubobject<UTextRenderComponent>(TEXT("CountdownNumber"));
	CountdownText->SetHorizontalAlignment(EHTA_Center);
	CountdownText->SetWorldSize(150.0f);
	RootComponent = CountdownText;

	CountdownTime = 3;


	TSharedPtr<FJsonObject> JsonObject = MakeShareable(new FJsonObject);
	JsonObject->SetStringField("Name", "Super Sword");
	JsonObject->SetNumberField("Damage", 15);
	JsonObject->SetNumberField("Weight", 3);

	FString OutputString;
	TSharedRef< TJsonWriter<> > Writer = TJsonWriterFactory<>::Create(&OutputString);
	FJsonSerializer::Serialize(JsonObject.ToSharedRef(), Writer);

	TSharedRef< TJsonWriter<TCHAR> > JsonWriter = TJsonWriterFactory<>::Create(&OutputString);


	//VisualMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));

	//static ConstructorHelpers::FObjectFinder<UStaticMesh> CubeVisualAsset(TEXT("/Game/Mesh/tree.tree"));

	//if (CubeVisualAsset.Succeeded())
////	{
		//VisualMesh->SetStaticMesh(CubeVisualAsset.Object);

//	}


}

void AMyActor::BeginDestroy()
{
	Super::BeginDestroy();
	GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Red, "Destroyed!!");

}


void AMyActor::SocketStart()
{

}

void AMyActor::MyFunction1(FString SomeString)
{
	AMyActor* P = nullptr;

	UE_LOG(LogTemp, Log, TEXT("123123 %s"), *SomeString);



}

// Called when the game starts or when spawned
void AMyActor::BeginPlay()
{
	Super::BeginPlay();

	//TextMesh->SetText(TEXT("1111"));

	UpdateTimerDisplay();
	GetWorldTimerManager().SetTimer(CountdownTimerHandle, this, &AMyActor::AdvanceTimer, 1.0f, true);

	const FString ServerURL = TEXT("ws://noeight.net:4000/socket/websocket?token=undefined&vsn=2.0.0"); // Your server URL. You can use ws, wss or wss+insecure.
	const FString ServerProtocol = TEXT("ws");              // The WebServer protocol you want to use.

	TSharedRef<IWebSocket> Socket = FWebSocketsModule::Get().CreateWebSocket(ServerURL, ServerProtocol);

	// We bind all available events
	Socket->OnConnected().AddLambda([Socket]() -> void {
		Socket->Send(TEXT("[\"3\",\"3\",\"room:lobby\",\"phx_join\",{}]"));
		// This code will run once connected.
		});

	Socket->OnConnectionError().AddLambda([](const FString& Error) -> void {
		// This code will run if the connection failed. Check Error to see what happened.
		});

	Socket->OnClosed().AddLambda([](int32 StatusCode, const FString& Reason, bool bWasClean) -> void {
		// This code will run when the connection to the server has been terminated.
		// Because of an error or a call to Socket->Close().
		GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Orange, "Closed!11");
		});



	Socket->OnMessage().AddLambda([this, Socket](const FString& Message) -> void {
		// This code will run when we receive a string message from the server.

		TSharedPtr<FJsonObject> JsonObject;

		TSharedRef< TJsonReader<> > Reader = TJsonReaderFactory<>::Create(Message);
		if (FJsonSerializer::Deserialize(Reader, JsonObject))
		{

			/*CountdownText->SetText(JsonObject->GetStringField(TEXT("Message")));*/
		}

		if (!(this->IsValidLowLevel())) {
			Socket->Close();
			return;
		}

		if (GEngine)
			//GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Orange, JsonObject->GetStringField(TEXT("Message")));
			GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Orange, Message);
		CountdownText->SetText(Message);

		});

	// And we finally connect to the server. 

	Socket->Connect();

	if (!Socket->IsConnected())
	{
		// Don't send if we're not connected.
		return;
	}

	// const TArray BinaryMessage = { 'H', 'e', 'l', 'l', 'o', ' ', 't', 'h', 'e', 'r', 'e', ' ', '!' };

	// Socket->Send(BinaryMessage.GetData(), sizeof(uint8) * BinaryMessage.Num());

	Socket->OnRawMessage().AddLambda([](const void* Data, SIZE_T Size, SIZE_T BytesRemaining) -> void {
		// This code will run when we receive a raw (binary) message from the server.
		if (GEngine)
			GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Yellow, TEXT("we receive a raw (binary) message!"));

		});

	Socket->OnMessageSent().AddLambda([](const FString& MessageString) -> void {
		// This code is called after we sent a message to the server.
		});

}

void AMyActor::UpdateTimerDisplay()
{
	CountdownText->SetText(FString::FromInt(FMath::Max(CountdownTime, 0)));
}


void AMyActor::AdvanceTimer2()
{
	CountdownText->SetText("111");
}

void AMyActor::AdvanceTimer()
{
	--CountdownTime;
	UpdateTimerDisplay();
	if (CountdownTime < 1)
	{
		// We're done counting down, so stop running the timer.
		GetWorldTimerManager().ClearTimer(CountdownTimerHandle);
		//Perform any special actions we want to do when the timer ends.
		CountdownHasFinished();
	}
}

void AMyActor::CountdownHasFinished_Implementation()
{
	//Change to a special readout
	CountdownText->SetText(TEXT("GO!"));
}

void AMyActor::SomeMessage_Implementation()
{
	//Change to a special readout
	
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

