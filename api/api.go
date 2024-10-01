package api

import (
	"log"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func Start() {
	app := fiber.New()
	app.Use(cors.New())

	api := app.Group("/api")

	// Run the status router.
	StatusRouter(api)

	// Start the API.
	log.Fatal(app.Listen(":6969"))
}

// StatusRouter is the router for all setup methods.
func StatusRouter(app fiber.Router) {
	// Run hit test.
	app.Get("/", HitTest())
}

// HitTest checks if the api server is running.
func HitTest() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		return ctx.JSON(&fiber.Map{
			"type":    "healthy",
			"message": string("Everything seems to be working, time is " + time.Now().Format("2006-01-02 15:04:05")),
		})
	}
}
