import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from http://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from http://v-play.net/licenseKey>"


    onSplashScreenFinished: { erikScene.start() }
    ErikScene{
        id: erikScene
    }


}

