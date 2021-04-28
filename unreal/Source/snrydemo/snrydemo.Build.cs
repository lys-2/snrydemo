// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class snrydemo : ModuleRules
{
	public snrydemo(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
	
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", 
			"InputCore", "WebSockets", "JsonUtilities", "Json",
		 "Sockets", "Networking", "ObjectDeliverer", "GameplayAbilities",
		 "GameplayTags", "GameplayTasks" });

		PrivateDependencyModuleNames.AddRange(new string[] {
		"ActionRPGLoadingScreen",
				"Slate",
				"SlateCore",
				"InputCore",
				"MoviePlayer",
			"HttpChunkInstaller", "LauncherChunkInstaller", "ChunkDownloader"
		});

		// Uncomment if you are using Slate UI
		// PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });

		// Uncomment if you are using online features
		// PrivateDependencyModuleNames.Add("OnlineSubsystem");

		// To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true
	}
}