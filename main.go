package main

import (
	"os"

	"github.com/kiweezi/container-demo/api"
)

func main() {
	// Check if the test mode is enabled.
	_, testMode := os.LookupEnv("TEST_MODE")

	// Start the API in test mode
	// if the environment variable is set.
	if !testMode {
		api.Start()
	} else {
		api.StartTest()
	}
}
