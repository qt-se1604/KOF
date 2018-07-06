import QtQuick 2.0
import VPlay 2.0
import QtMultimedia 5.0

Item {
    id:audioManager

    Component.onCompleted: handleMusic()
    property alias playerHit:playerHit
    property alias menuMusic:menuMusic
//    property alias hit: hit

    /**
     * Background Music ----------------------------------
     */
    BackgroundMusic{
        id: menuMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/s1.mp3"
    }
    BackgroundMusic{
        id: setMusic
        autoPlay: false
        source: "../../assets/audio/MenuMusic/S1.mp3"
    }

    BackgroundMusic {
        id: gameMusic1
        autoPlay: false
        source:"../../assets/music/background2.mp3"
    }
    BackgroundMusic {
        id: gameMusic2
        autoPlay: false
        source:"../../assets/music/background1.mp3"
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

    SoundEffectVPlay{
        id: playerHit
        source:"../../assets/music/dazhao2.wav"
    }
    SoundEffectVPlay{
        id:timeover
        source: "../../assets/music/timeover.wav"
    }
    SoundEffectVPlay{
        id:hited1
        source: "../../assets/music/sddj.wav"
    }
    SoundEffectVPlay {
       id: hited
        source: "../../assets/music/hited.wav"
    }
    SoundEffectVPlay{
        id:ko
        source: "../../assets/music/KO.wav"

    }
    SoundEffectVPlay{
        id:option
        source: "../../assets/music/option.wav"
    }

    // this function sets the music, depending on the current scene and the gameScene's state
    function handleMusic() {
        if(activeScene === menuScene){
            audioManager.startMusic(menuMusic)
        }
        else if(activeScene === setScene){
            audioManager.startMusic(setMusic)
        }
        else if(activeScene === gameScene) {
            if(gameScene.gamemusic === 1)
                audioManager.startMusic(gameMusic1)
            else if(gameScene.gamemusic === 2)
                audioManager.startMusic(gameMusic2)
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
        setMusic.stop()
        gameMusic1.stop()
        gameMusic2.stop()
        loadingMusic.stop()
        finishMusic.stop()

        // play the music
        music.play()

    }


    // play the sound effect with the given name
    function playSound(sound) {
        if(sound === "playerJump")
            playerJump.play()
        else if(sound === "playerHit"){
            playerHit.play()
        }else if(sound === "hited")
        {
            hited.play()
        }else if(sound==="timeover"){

            timeover.play()
        }
        else if(sound==="KO"){

            ko.play()
        }else if(sound==="option"){

            option.play()
        }
        else if(sound==="hited1")
        {
            hited1.play()
        }else if(sound === "playerInvincible")
            playerInvincible.play()
        else if(sound === "finish")
        {
            finish.play()
            console.debug("unknown sound name:", sound)
        }
    }

    // stop the sound effect with the given name
    function stopSound(sound) {
        if(sound === "playerInvincible")
            playerInvincible.stop()
        else
            console.debug("unknown sound name:", sound)
    }
    function stopaction(music){
        music.stop()
    }


}
