// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"

#include "Components/TextRenderComponent.h"
#include "IWebSocket.h"       // Socket definition
#include "WebSocketsModule.h"

#include "MyActor.generated.h"


UCLASS()
class SNRYDEMO_API AMyActor : public AActor
{

	GENERATED_BODY()
	UFUNCTION(BlueprintCallable, Category = "123123")
	static void MyFunction1(FString SomeString);

public:	
	// Sets default values for this actor's properties

	/** Show the native loading screen, such as on a map transfer. If bPlayUntilStopped is false, it will be displayed for PlayTime and automatically stop */
	UFUNCTION(BlueprintCallable, Category = Loading)
		static void PlayLoadingScreen(bool bPlayUntilStopped, float PlayTime);

	/** Turns off the native loading screen if it is visible. This must be called if bPlayUntilStopped was true */
	UFUNCTION(BlueprintCallable, Category = Loading)
		static void StopLoadingScreen();

	AMyActor();


	int32 CountdownTime;
	UTextRenderComponent* CountdownText;
	void UpdateTimerDisplay();

	void AdvanceTimer();

	void AdvanceTimer2();

	UFUNCTION(BlueprintNativeEvent)
	void SomeMessage();
	virtual void SomeMessage_Implementation();

	UFUNCTION(BlueprintNativeEvent)
	void CountdownHasFinished();
	virtual void CountdownHasFinished_Implementation();

	FTimerHandle CountdownTimerHandle;

	UPROPERTY(VisibleAnywhere)
	UStaticMeshComponent* VisualMesh;

	UPROPERTY(EditAnywhere)
	UTextRenderComponent* TextMesh;



	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "SomeCategory")
	FString SomeText;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "FloatingActor")
		float FloatSpeed = 20.0f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "FloatingActor")
		float RotationSpeed = 20.0f;


protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

	virtual void BeginDestroy();
	virtual void SocketStart();

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

};
