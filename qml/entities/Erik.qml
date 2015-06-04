import QtQuick 2.0
import VPlay 2.0

EntityBase{
    entityType: "erik"

    CircleCollider{
        radius: sprite.width/2
        anchors.centerIn: parent

        //Bounciness
        fixture.restitution: 0.5
    }

    MultiResolutionImage{
        id: sprite
        source: "../../assets/img/balloon.png"
        anchors.centerIn: parent
    }
    MultiPointTouchArea{
        anchors.fill: sprite
        onPressed: {
            //Touching erik removes him
            if(erikScene.gameRunning){
                erikScene.eriks--
                erikScene.smackSound.play()
                removeEntity()
            }
        }

    }

    //Gives us a erik at a random position when created

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(15, erikScene.width-15)
        y = erikScene.height
    }
}

