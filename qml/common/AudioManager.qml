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

        source: "../../assets/audio/music/menuMusic.mp3"
    }

    BackgroundMusic {
      id: playMusic

      autoPlay: false

      source: "../../assets/audio/music/playMusic.mp3"
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
      if(activeScene === gameScene) {
        if(gameScene.state == "play" || gameScene.state == "test")
          audioManager.startMusic(playMusic)
        else if(gameScene.state == "edit")
          audioManager.startMusic(editMusic)
      }
      else {
        audioManager.startMusic(menuMusic)
      }
    }

    function playSound(){}


}
