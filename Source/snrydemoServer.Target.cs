// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class snrydemoServerTarget : TargetRules //Change this line according to the name of your project
{
    public snrydemoServerTarget(TargetInfo Target) : base(Target) //Change this line according to the name of your project
    {
        Type = TargetType.Server;
        DefaultBuildSettings = BuildSettingsVersion.V2;
        ExtraModuleNames.Add("snrydemo"); //Change this line according to the name of your project
	//	bCompileChaos = true;
	//	bUseChaos = true;
	}
}
