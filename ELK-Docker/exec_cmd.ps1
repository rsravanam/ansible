#docker pull ubuntu:14.04
#docker pull ubuntu:16.04
#docker image ls
#docker tag ccc7a11d65b1 sravanam1242/private_docker:ubuntu-16.04
#docker push sravanam1242/private_docker:ubuntu-16.04

# .\exec_cmd.ps1 -USERNAME $ENV:USERNAME -PASSWORD $ENV:PASSWORD -ONLY_DOCKER_COMMIT $ENV:ONLY_DOCKER_COMMIT -BUILD_DOCKER_FILE $ENV:BUILD_DOCKER_FILE


#		DOCKER ARGUMETNS

#Set-ExecutionPolicy RemoteSigned

param(
    [Parameter(Mandatory=$true)]
    [string]$USERNAME,

    [Parameter(Mandatory=$true)]
    [string]$PASSWORD,
	
	[Parameter(Mandatory=$false)]
    [string]$ONLY_DOCKER_COMMIT,
	
	[Parameter(Mandatory=$false)]
    [string]$BUILD_DOCKER_FILE
)



$IMAGE_REPO = "sravanam1242/private_docker"
$IMAGE_TAG = "ELK-Stack-POC-ubuntu-14.04"
$DOCKER_FILE_LOCATION = "."
$DOCKER_IMAGE_ID = docker images -q $IMAGE_REPO':'$IMAGE_TAG
#$USERNAME = Read-Host 'What is your password?'
#$PASSWORD = Read-Host 'What is your password?' -AsSecureString

IF ( ( $ONLY_DOCKER_COMMIT -eq "true" ) -and ( $BUILD_DOCKER_FILE -eq "true" ) )
{
  Write-Output "**************** BOTH ACTIONS ARE NOT PERMITTED AT A TIME ****************"
  Write-Output "**************** IF INSIDE IMAGE CHNAGEED, THEN SELECT ONLY_DOCKER_COMMIT ****************"
  Write-Output "**************** IF DOCKER FILE CHANGED, THEN SELECT BUILD_DOCKER_FILE  ******************"
  Write-Output "**************** SELECT ONLY ONE OPTION BASED ON WORK DONE ****************"
  exit 1
}
ELSE
{
  Write-Output "**************** EXECUTING DOCKER COMMANDS ****************"
}
IF ( ( $ONLY_DOCKER_COMMIT -eq "true" ) -and ( $BUILD_DOCKER_FILE -eq "false" ) )
{
  Write-Output "**************** COMMITING CHANGES ****************"
  Write-Output "DOCKER_IMAGE_ID $MESSAGE"
  docker login -u $USERNAME -p $PASSWORD
  docker commit $DOCKER_IMAGE_ID $IMAGE_REPO':'$IMAGE_TAG
  docker push $IMAGE_REPO':'$IMAGE_TAG
  Write-Output "***************************************************"
}
ELSE
{
  Write-Output "***** SKIP ONLY_DOCKER_COMMIT ****"
}

Write-Output "***************************************************"

IF ( ( $BUILD_DOCKER_FILE -eq "true" ) -and ( $ONLY_DOCKER_COMMIT -eq "false" ) )
{
  $MESSAGE = "**********CURRENT DOCKER IMAGE DETAILS**********"
  
  Write-Output "DOCKER_IMAGE_ID $MESSAGE"
  Write-Output ""
  Write-Output "IMAGE_REPO is $IMAGE_REPO"
  Write-Output "IMAGE_TAG is $IMAGE_TAG"
  Write-Output "DOCKER_FILE_LOCATION is $DOCKER_FILE_LOCATION"
  Write-Output "DOCKER_IMAGE_ID is $DOCKER_IMAGE_ID"
  Write-Output ""
  Write-Output "***********************************************"
  
  #Apache Mesos Master Installation step (build with docker file)
  docker login -u $USERNAME -p $PASSWORD
  Write-Output "----------------------------- docker build -t $IMAGE_REPO':'$IMAGE_TAG $DOCKER_FILE_LOCATION"
  docker build -t $IMAGE_REPO':'$IMAGE_TAG $DOCKER_FILE_LOCATION
  Write-Output "----------------------------- docker commit $DOCKER_IMAGE_ID $IMAGE_REPO':'$IMAGE_TAG"
  docker commit $DOCKER_IMAGE_ID $IMAGE_REPO':'$IMAGE_TAG
  Write-Output "----------------------------- docker tag $IMAGE_TAG $IMAGE_REPO':'$IMAGE_TAG"
  docker tag $IMAGE_TAG $IMAGE_REPO':'$IMAGE_TAG
  Write-Output "----------------------------- docker push $IMAGE_REPO':'$IMAGE_TAG"
  docker push $IMAGE_REPO':'$IMAGE_TAG
  Start-Sleep -s 10
  
  $MESSAGE = "**********LATEST DOCKER IMAGE DETAILS**********"
  Write-Output $MESSAGE
  Write-Output ""
  Write-Output "IMAGE_REPO is $IMAGE_REPO"
  Write-Output "IMAGE_TAG is $IMAGE_TAG"
  Write-Output "DOCKER_FILE_LOCATION is $DOCKER_FILE_LOCATION"
  Write-Output "DOCKER_IMAGE_ID is $DOCKER_IMAGE_ID"
  Write-Output ""
  Write-Output "*********************************************"
}
ELSE
{
  Write-Output "***** SKIP BUILD_DOCKER_FILE ****"
}