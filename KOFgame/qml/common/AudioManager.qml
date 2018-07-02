import QtQuick 2.0
import VPlay 2.0
import QtMultimedia 5.0

Item {
    id:audioManager

    Component.onCompleted: handleMusic()

    /**
     * Background Music ----------------------------------
     */
    BackgroundMusic{
        id: menuMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/s1.mp3"
    }

    BackgroundMusic {
        id: gameMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/S2.mp3"
    }
    BackgroundMusic{
        id: loadingMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/S3.mp3"
    }
    BackgroundMusic{
        id: finishMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/S4.mp3"
    }


    /**
     * Sounds ----------------------------------
     */
    SoundEffectVPlay {
        id: click
        source: "../../assets/audio/sounds/click1.wav"
    }

    SoundEffectVPlay {
        id: start
        source: "../../assets/audio/sounds/yahoo.wav"
    }

    // this function sets the music, depending on the current scene and the gameScene's state
    function handleMusic() {
        if(activeScene === menuScene){
            console.debug("1")
            audioManager.startMusic(menuMusic)
        }

        else if(activeScene === gameScene) {
            audioManager.startMusic(gameMusic)
            //        if(gameScene.state == "play" || gameScene.state == "stop")
            //          audioManager.startMusic(playMusic)
            //        else if(gameScene.state == "edit")
            //          audioManager.startMusic(editMusic)
        }
        else if(activeScene === loadingScene){
            audioManager.startMusic(loadingMusic)
        }
        else {
            audioManager.startMusic(finishMusic)
        }
    }

    function startMusic(music) {
        // if music is already playing, we don't have to do anything

        if(music.playing)
            return

        // otherwise stop all music tracks
        menuMusic.stop()
        gameMusic.stop()
        loadingMusic.stop()
        finishMusic.stop()

        // play the music
        music.play()
        console.debug("2")
    }

    // play the sound effect with the given name
    function playSound(sound) {
        if(sound === "playerJump")
            playerJump.play()
        else if(sound === "playerHit")
            playerHit.play()
        else if(sound === "playerDie")
            playerDie.play()
        else if(sound === "playerInvincible")
            playerInvincible.play()
        else if(sound === "collectCoin")
            collectCoin.play()
        else if(sound === "collectMushroom")
            collectMushroom.play()
        else if(sound === "finish")
            finish.play()
        else if(sound === "opponentWalkerDie")
            opponentWalkerDie.play()
        else if(sound === "opponentJumperDie")
            opponentJumperDie.play()
        else if(sound === "start")
            start.play()
        else if(sound === "click")
            click.play()
        else if(sound === "dragEntity")
            dragEntity.play()
        else if(sound === "createOrDropEntity")
            createOrDropEntity.play()
        else if(sound === "removeEntity")
            removeEntity.play()
        else
            console.debug("unknown sound name:", sound)
    }

    // stop the sound effect with the given name
    function stopSound(sound) {
        if(sound === "playerInvincible")
            playerInvincible.stop()
        else
            console.debug("unknown sound name:", sound)
    }


}
