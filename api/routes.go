package api

import (
	"time"

	"github.com/gofiber/fiber/v2"
)

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

// LongRouter is the router for all setup methods.
func LongRouter(app fiber.Router) {
	// Run hit test.
	app.Get("/long/", LongTest())
}

// LongTest checks if the api server is running,
// but deliberately takes a long time to respond.
func LongTest() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		// Sleep to emulate a long running process.
		time.Sleep(15 * time.Second)
		return ctx.JSON(&fiber.Map{
			"type":    "healthy",
			"message": string("Everything seems to be working, time is " + time.Now().Format("2006-01-02 15:04:05")),
		})
	}
}
