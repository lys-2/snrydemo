// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "MyActor.generated.h"

UCLASS()
class SNRYDEMO_API AMyActor : public AActor
{
	GENERATED_BODY()

	UFUNCTION(BlueprintCallable, Category = "123123")
	static void MyFunction1(FString SomeString);

public:	
	// Sets default values for this actor's properties
	AMyActor();
	UPROPERTY(EditAnywhere, Category = "Damage")
	int32 TotalDamage;

	int32 TotalDamage2;
	int threedim[111][111][111];



protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

};
