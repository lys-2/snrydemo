// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"

#include "Components/TextRenderComponent.h"


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

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

};
