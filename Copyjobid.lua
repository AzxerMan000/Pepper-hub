local jobId = game.JobId
    print("Current Job ID:", jobId)

    if setclipboard then
        setclipboard(jobId)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Job ID",
            Text = "Copied to clipboard!",
            Duration = 4
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Job ID",
            Text = "Job ID: " .. jobId,
            Duration = 6
        })
end
