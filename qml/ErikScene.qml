import QtQuick 2.0
import VPlay 2.0
import "entities"

Scene{
    id: erikScene
    property alias smackSound: smackSound
    property int eriks: 0
    property int erikMax: 100
    property int time: 20
    property bool gameRunning: false

    sceneAlignmentY: "top"

    EntityManager{
        id: entityManager
        entityContainer: erikScene
    }

    PhysicsWorld{z:1; gravity.y: 0.5; debugDrawVisible: false}

    Image{source: "../assets/img/clouds.png"; anchors.fill: gameWindowAnchorItem}

    SoundEffectVPlay{id:smackSound; source: "../assets/snd/balloonPop.wav"}

    BackgroundMusic{source: "../assets/snd/music.mp3"}

    //Left wall
    Wall{height: parent.height+50; anchors.right: parent.left}
    //Right wall
    Wall{height: parent.height+50; anchors.left: parent.right}
    //Ceileing
    Wall{width:parent.width; anchors { bottom:parent.top; left: gameWindowAnchorItem.left}}


    Text{
        id: infoText; height: 40; text: "Loading Eriks..."
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        z: 2

    }



    Text{
        id: timeText; height: 40; text: "Time: "+ erikScene.time
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        z: 2
    }


    // starts the game
    function start() {
        spawnEriks.start()
    }

    // clear all baloons and reset properties to start values
    function reset() {
        entityManager.removeEntitiesByFilter(["erik"])
        eriks = 0
        time = 20
        infoText.text = "Loading balloons..."
    }

    Timer{
        id: spawnEriks
        interval: 20
        repeat: true
        onTriggered:{
            //creating new baloon
            entityManager.createEntityFromUrl(Qt.resolvedUrl("entities/Erik.qml"))
            eriks++;
            if(eriks === erikMax){
                running = false
                gameRunning = true
                infoText.text = "Hurry!"
            }
        }
    }
    Timer{
        id: gameTimer
        running: gameRunning
        repeat: true
        onTriggered: {
            time--

            if(time === 0||eriks === 0){
                gameRunning = false
                if(eriks === 0) infoText.text = "Great! The world no longer suffers from Erik"
                else if(eriks < erikMax/2) infoText.text = "Well, atleast you took out some of them..."
                else infoText.text = "Damnit! Erik will now take over the world!!"
                restartAfterDelay.start()
            }
        }
    }
    // reset and start game 4 seconds after it is over
    Timer {
        id: restartAfterDelay
        interval: 4000
        onTriggered: {
            erikScene.reset()
            erikScene.start()
        }
    }
}

