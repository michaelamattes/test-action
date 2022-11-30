package common

import (
	"log"
	"os"
)

func Log(message string) {
	log.Printf("%s", message)
}

func LogColor(color string, message string) {

	reset := "\033[0m"
	switch color {
	case "red":
		color = "\033[31m"
	case "green":
		color = "\033[32m"
	case "yellow":
		color = "\033[33m"
	case "blue":
		color = "\033[34m"
	case "white":
		color = "\033[97m"
	}

	log.Printf(color+"%s", message+reset)
}

func LogDefault(message string) {
	LogColor("red", message+" actually not configurated.")
}

func LogMiss(message string) {
	LogColor("red", "Missing configuration for "+message+".")
}

func GetTestSettings() map[string]string {
	os_path, _ := os.Getwd()
	path := os_path + "/../../../..tests"

	settings := make(map[string]string)
	settings["path"] = path

	return settings
}
