package api

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

const (
	apiPort     = ":8080"
	idleTimeout = 30 * time.Second
)

// Start starts the API.
func Start() {
	app := fiber.New()
	app.Use(cors.New())

	api := app.Group("/api")

	// Run the routers.
	StatusRouter(api)
	LongRouter(api)

	// Start the API.
	log.Fatal(app.Listen(apiPort))
}

// StartTest starts the API for testing.
func StartTest() {
	app := fiber.New(fiber.Config{
		IdleTimeout: idleTimeout,
	})
	app.Use(cors.New())

	api := app.Group("/api")

	// Run the routers.
	StatusRouter(api)
	LongRouter(api)

	// Start the API and listen for an interrupt
	// from a different goroutine.
	go func() {
		if err := app.Listen(apiPort); err != nil {
			log.Panic(err)
		}
	}()

	// Create channel to signify a signal being sent.
	c := make(chan os.Signal, 1)
	// When an interrupt or termination signal is sent, notify the channel.
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)

	// This blocks the main thread until an interrupt is received.
	<-c
	fmt.Println("Gracefully shutting down...")
	app.Shutdown()

	fmt.Println("Running cleanup tasks...")

	// Cleanup tasks can go here
	// db.Close()
	// redisConn.Close()
	fmt.Println("Successfully shutdown.")
}
