set delaySec to 0.5
global currentUrl
global currentPos
global currentDur

set currentUrl to ""
set currentPos to 0
set currentDur to 0

repeat
    local nextUrl
    local nextPos
    local nextDur
    local shouldAlter

    set nextUrl to nextUrl()
    set nextPos to nextPos()
    set nextDur to nextDur()

    set shouldAlter to shouldAlter(nextUrl, nextPos)

    if shouldAlter is true then
        if currentUrl ≠ nextUrl then setPlayUrl(currentUrl)
        setPlayPos(currentPos)
    end if

    if shouldAlter ≠ true then
        set currentUrl to nextUrl
        set currentPos to nextPos
        set currentDur to nextDur
    end if

    delay delaySec
end repeat

on shouldAlter(nextUrl, nextPos)
    if currentUrl ≠ "" and currentDur ≠ 0 then
        if nextUrl ≠ currentUrl and currentPos < currentDur - 2 then
            log "Skipped song"
            return true
        end if
    end if

    if nextUrl = currentUrl and nextPos ≠ 0 then
        if nextPos < currentPos or nextPos > currentPos + 2 then
            log "Skipped playhead"
            return true
        end if
    end if

    return false
end shouldAlter

on nextPos()
    tell application "Spotify"
        local var
        set var to player position as real
        return var
    end tell
end nextPos

on nextUrl()
    tell application "Spotify"
        local var
        set var to spotify url of current track as string
        return var
    end tell
end nextUrl

on nextDur()
    tell application "Spotify"
        local var
        set var to duration of current track as string
        return var / 1000
    end tell
end nextDur

on setPlayPos(currentPos)
    tell application "Spotify"
        set player position to currentPos
    end tell
end setPlayPos

on setPlayUrl(currentUrl)
    tell application "Spotify"
        play track currentUrl
    end tell
end setPlayUrl

on setPlay()
    tell application "Spotify" to play
end setPlay
